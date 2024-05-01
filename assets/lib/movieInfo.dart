import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rstreamingent/sharedpreferenceutil.dart';
import 'package:rstreamingent/videoplayer.dart';
import 'bottomAppBar/bottomAppBar.dart';
import 'favorites.dart';
import 'favorites_utils.dart'; // Import the favorites page

class MovieInfoPage extends StatefulWidget {
  final String movieName;
  final String description;
  final String poster;
  final String videoPath;
  final int position;

  const MovieInfoPage({
    Key? key,
    required this.movieName,
    required this.description,
    required this.poster,
    required this.videoPath,
    required this.position,
  }) : super(key: key);

  @override
  _MovieInfoPageState createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }
  Future<void> _checkIfFavorite() async {
    final isFavorite = FavoritesUtil.favorites.any(
          (item) => item['movieName'] == widget.movieName,
    );
    setState(() {
      this.isFavorite = isFavorite;
    });
  }

  Future<void> _updateWatchHistory() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Get the user document
      DocumentSnapshot userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        // Create the user document with initial data
        await userDoc.set({'watch_history': []});
        print('User document created for UID: $uid');
        return; // Return early to avoid further processing
      }

      // Ensure 'watch_history' field exists in the document
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('watch_history')) {
        List<String> watchHistory = List.from(userData['watch_history'] ?? []);
        String newEntry = jsonEncode({
          'dateTime': DateTime.now().toString(),
          'movieName': widget.movieName,
          'poster': widget.poster,
          'description': widget.description,
          'path': widget.videoPath,
          'positionInSeconds':
              await SharedPreferencesUtils.getLastPausedPosition(
                  widget.videoPath),
        });

        int existingIndex = watchHistory.indexWhere((entry) {
          Map<String, dynamic> decodedEntry = jsonDecode(entry);
          return decodedEntry['movieName'] == widget.movieName;
        });

        if (existingIndex != -1) {
          // Movie already exists, update the entry
          watchHistory[existingIndex] = newEntry;
        } else {
          // Movie doesn't exist, add a new entry
          watchHistory.add(newEntry);
        }
        // Update the watch history in Firestore
        await userDoc.update({'watch_history': watchHistory});

        print('Watch history updated successfully');
      } else {
        print('Watch history field does not exist in the user document.');
      }
    } catch (e) {
      print('Error updating watch history: $e');
    }
  }

  Future<int> _getDatabaseStartingPosition() async {
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
              List.from(userData['watch_history'] ?? []);

          // Find the entry for the current movie in watchHistory
          String currentMovieEntry = watchHistory.firstWhere(
            (entry) {
              Map<String, dynamic> decodedEntry = jsonDecode(entry);
              return decodedEntry['movieName'] == widget.movieName;
            },
            orElse: () => '',
          );

          if (currentMovieEntry.isNotEmpty) {
            Map<String, dynamic> currentMovieData =
                jsonDecode(currentMovieEntry);
            int positionInSeconds = currentMovieData['positionInSeconds'] ?? 0;
            return positionInSeconds;
          }
        }
      }

      // Return a default value if the data is not found
      return 0;
    } catch (e) {
      print('Error fetching position from the database: $e');
      // Return a default value in case of an error
      return 0;
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      // Add to favorites
      FavoritesUtil.addToFavorites(
        widget.movieName,
        widget.poster,
        widget.description,
      );
    } else {
      // Remove from favorites
      FavoritesUtil.removeFromFavorites(widget.movieName);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 0,
            ),
            SizedBox(
              child: Row(children: [
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      widget.poster,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Text(
                            'Error loading image'); // Placeholder or error handling
                      },
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Reset the watch history position for this movie
                              SharedPreferencesUtils.saveLastPausedPosition(
                                  widget.videoPath, 0);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return VideoPage(
                                      videoPath: widget.videoPath,
                                      startingPosition:
                                          0, // Start from the beginning
                                    );
                                  },
                                ),
                              );
                            },
                            color: Colors.white,
                            highlightColor: Colors.white,
                            iconSize: 25,
                            icon: const Icon(
                              Icons.replay_circle_filled,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Restart',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              _updateWatchHistory();
                              int startingPosition =
                                  await _getDatabaseStartingPosition();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return VideoPage(
                                      videoPath: widget.videoPath,
                                      startingPosition: startingPosition,
                                    );
                                  },
                                ),
                              );
                            },
                            color: Colors.white,
                            highlightColor: Colors.white,
                            iconSize: 25,
                            icon: const Icon(
                              Icons.play_circle_fill,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Play',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 9),
                      Column(
                        children: [
                          IconButton(
                            onPressed: _toggleFavorite,
                            iconSize: 25,
                            //bool alreadyExists = favorites.any((element) => element['movieName'] == movieName);
                            icon: isFavorite
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Favorites',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Add functionality for trailer
                            },
                            color: Colors.white,
                            highlightColor: Colors.white,
                            iconSize: 25,
                            icon: const Icon(
                              Icons.ondemand_video,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Trailer',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  Text(
                    ' ${widget.movieName} ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '  ${widget.description}',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarHelper.build(context),
    );
  }
}
