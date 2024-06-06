import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'movieInfo.dart';
import 'bottomAppBar/bottomAppBar.dart';

class WatchHistoryPage extends StatefulWidget {
  const WatchHistoryPage({Key? key}) : super(key: key);

  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  Future<bool> onWillPop(BuildContext context) async {
    // Navigate to HomePage and clear navigation stack
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Watch History',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _deleteAllWatchHistory();
                      },
                      child: Text('Clear All'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.red
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 20, bottom: 20),
                child: Text(
                  'Recently Watched : ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _getWatchHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> watchHistory =
                      snapshot.data as List<Map<String, dynamic>>;
                      return ListView.builder(
                        itemCount: watchHistory.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> decodedEntry =
                          watchHistory[index];

                          String movieName = decodedEntry['movieName'];
                          String poster = decodedEntry['poster'];
                          String path = decodedEntry['path'];
                          String description = decodedEntry['description'];
                          int positionInSeconds =
                          decodedEntry['positionInSeconds'];

                          // Inside the ListView.builder
                          return GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MovieInfoPage(
                                    movieName: movieName,
                                    description: description,
                                    poster: poster,
                                    videoPath: path,
                                    position: positionInSeconds,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Color(0xff161a25), // Dark background color
                                borderRadius: BorderRadius.circular(20), // Rounded corners
                              ),
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: NetworkImage(poster),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 6.0),
                                          SingleChildScrollView(
                                            child: Text(
                                              movieName,
                                              style: GoogleFonts.rozhaOne(
                                                textStyle:TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,

                                                ),
                                              // style: const TextStyle(
                                              //   color: Colors.white,
                                              //   fontSize: 22,
                                              //   fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [],
                                          ),
                                          const SizedBox(height: 8.0),

                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _deleteWatchHistoryItem(decodedEntry),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarHelper.build(context),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getWatchHistory() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('watch_history')) {
          List<String> watchHistory =
          List<String>.from(userData['watch_history'] ?? []);

          List<Map<String, dynamic>> watchHistoryList = watchHistory
              .map((entry) => jsonDecode(entry) as Map<String, dynamic>)
              .toList();

          watchHistoryList.sort((a, b) {
            DateTime timeA = DateTime.parse(a['dateTime']);
            DateTime timeB = DateTime.parse(b['dateTime']);
            return timeB.compareTo(timeA);
          });

          return watchHistoryList;
        } else {
          return []; // No watch history found
        }
      } else {
        return []; // User document does not exist
      }
    } catch (e) {
      print('Error getting watch history: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<void> _updateWatchHistory(
      String movieName, String description, String poster, String path) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;

        if (userData == null) {
          // If no watch_history field exists, create one with the new entry
          await userDoc.set({
            'watch_history': [
              jsonEncode(_createWatchEntry(movieName, description, poster, path))
            ],
          });
        } else if (userData.containsKey('watch_history')) {
          // If watch_history field exists, update the list
          List<String> watchHistory =
          List.from(userData['watch_history'] ?? []);

          // Remove any existing entry with the same movieName
          watchHistory.removeWhere((entry) {
            Map<String, dynamic> decodedEntry = jsonDecode(entry);
            return decodedEntry['movieName'] == movieName;
          });

          // Add the new entry to the top of the list
          watchHistory.insert(
              0,
              jsonEncode(
                  _createWatchEntry(movieName, description, poster, path)));

          // Update the watch_history field in Firestore
          await userDoc.update({'watch_history': watchHistory});
        }
      }
    } catch (e) {
      print('Error updating watch history: $e');
    }
  }

  Future<void> _deleteAllWatchHistory() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(uid);

      await userDoc.update({'watch_history': []});

      // Trigger UI rebuild
      setState(() {});
    } catch (e) {
      print('Error deleting watch history: $e');
    }
  }
  Future<void> _deleteWatchHistoryItem(Map<String, dynamic> item) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('watch_history')) {
          List<String> watchHistory = List<String>.from(userData['watch_history'] ?? []);

          // Remove the item from the watch_history list
          watchHistory.removeWhere((entry) {
            Map<String, dynamic> decodedEntry = jsonDecode(entry);
            return decodedEntry['movieName'] == item['movieName'];
          });

          // Update the watch_history field in Firestore
          await userDoc.update({'watch_history': watchHistory});

          // Trigger UI rebuild
          setState(() {});
        }
      }
    } catch (e) {
      print('Error deleting watch history item: $e');
    }
  }


  Map<String, dynamic> _createWatchEntry(
      String movieName, String Description, String poster, String path) {
    return {
      'dateTime': DateTime.now().toString(),
      'movieName': movieName,
      'description': Description,
      'poster': poster,
      'path': path,
    };
  }
}
