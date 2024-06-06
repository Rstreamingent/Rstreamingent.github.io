import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rstreamingent/movieInfo.dart';
import 'dart:convert';

import 'package:rstreamingent/stream.dart';

class fireapi extends StatefulWidget {
  const fireapi({Key? key}) : super(key: key);

  @override
  _fireapiState createState() => _fireapiState();
}

class _fireapiState extends State<fireapi> {
  Map<String, dynamic>? jsonData;
  List<dynamic> collections = [];

  @override
  void initState() {
    super.initState();
    _fetchJSONData();
  }

  Future<void> _fetchJSONData() async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("Contents").doc("Dataset");

    try {
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          jsonData = data; // Update state variable

          // Assuming your data is stored in a field named "data"
          if (data.containsKey('Data')) {
            try {
              collections = jsonDecode(data['Data']) ?? []; // Decode data field
            } on FormatException catch (e) {
              print("Error decoding JSON data: $e");
              // Handle decoding error (e.g., show a message to the user)
            }
          } else {
            print("Missing 'data' field in Firestore document");
            // Handle missing field (e.g., show a message or provide default data)
          }
        });
      } else {
        print("Document not found in Firestore");
      }
    } on FirebaseException catch (e) {
      print("Error getting document: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('JSON Data'),
      ),
      body: jsonData == null
          ? const Center(child: CircularProgressIndicator())
          : (collections.isEmpty)
          ? const Center(child: Text('No Collections Found'))
          : buildListView(), // Call buildListView if data available
    );
  }


  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        var collection = collections[index];
        var collectionName = collection['collectionName'];
        if (collectionName == 'featurefilms') {
          collectionName = "Movies";
        }
        var collectionData = collection['collectionData'];
        Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StreamPage(
                                data: collectionData,
                                collectionName: collectionName)),
                      );
                    },
                    child: const Text(
                      'Movies',
                      style: TextStyle(
                          backgroundColor: Colors.amber, color: Colors.black),
                    ))
              ],
            ),
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    collectionName.toString().toUpperCase(),

                    style: GoogleFonts.aboreto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //       fontSize: 15,
                    //       // fontFamily:,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StreamPage(
                                data: collectionData,
                                collectionName: collectionName)),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: collectionData.length,
                  itemBuilder: (context, index) {
                    var data = collectionData[index];
                    return GestureDetector(
                      onTap: () {
                        try {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MovieInfoPage(
                                movieName: data['name'] ?? 'No Name Available',
                                description: data['Description'] ??
                                    'No Description available',
                                poster: data['poster'] ?? '',
                                videoPath: data['video'] ?? '',
                                position: 0,
                              ),
                            ),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'There was an error loading this item.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Report'),
                                    onPressed: () {
                                      // Store data in Firestore
                                      FirebaseFirestore.instance
                                          .collection('reportedvideos')
                                          .add({
                                        'VideoPath': data['video'] ?? '',
                                        'videoName': data['name'] ?? '',
                                        'error': e.toString(),
                                        'timestamp': DateTime.now(),
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth:
                            150), // Adjust the maximum width as needed
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final double itemWidth = constraints.maxWidth;
                            final double itemHeight = itemWidth *
                                (9 / 16); // Maintain the 16/9 aspect ratio

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: itemWidth,
                                      height: itemHeight,
                                      child: Image.network(
                                        data['poster'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                SizedBox(
                                  width: itemWidth,
                                  child: Center(
                                    child: Text(
                                      data['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.rozhaOne(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                )),
          ],
        );
      },
    );
  }

}


///import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rstreamingent/search.dart';
// import 'package:rstreamingent/stream.dart';
// import 'package:shimmer/shimmer.dart';
// import 'movieInfo.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'bottomAppBar/bottomAppBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   List<dynamic> collections = [];
//   bool isLoading = true;
//   bool isLoadingApi = false;
//   late TabController _tabController;
//   Map<String, dynamic>? jsonData;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   Future<void> fetchData() async {
//     final db = FirebaseFirestore.instance;
//     final docRef = db.collection("Contents").doc("Dataset");
//
//     setState(() {
//       isLoadingApi = true;
//     });
//
//     try {
//       final docSnapshot = await docRef.get();
//       if (docSnapshot.exists) {
//         final data = docSnapshot.data() as Map<String, dynamic>;
//         setState(() {
//           jsonData = data;
//           isLoading = false;
//           isLoadingApi = false;
//           storeDataInSharedPreferences(collections);
//         });
//         if (data.containsKey('Data')) {
//           try {
//             collections = jsonDecode(data['Data']) ?? []; // Decode data field
//           } on FormatException catch (e) {
//             print("Error decoding JSON data: $e");
//             // Handle decoding error (e.g., show a message to the user)
//           }
//         } else {
//           print("Missing 'data' field in Firestore document");
//           // Handle missing field (e.g., show a message or provide default data)
//         }
//       } else {
//         print("Document not found in Firestore");
// }
// } on FirebaseException catch (e) {
//       setState(() {
//         isLoading = false;
//         isLoadingApi = false;
//         print('Error: $e');
//       });
//     }
//   }
//
//   Future<void> storeDataInSharedPreferences(List<dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(data);
//     await prefs.setString('cachedData', jsonString);
//   }
//   Future<List<dynamic>> getCachedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('cachedData');
//     print(jsonString);
//     if (jsonString != null) {
//       return jsonDecode(jsonString);
//     }
//     return [];
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leadingWidth: 200,
//         leading: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               width: 10,
//             ),
//             Image.asset(
//               'assets/icons/R-streaming-TEXT-logo.png',
//               height: MediaQuery.of(context).size.height * 0.5,
//             ),
//           ],
//         ),
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SearchPage(collections: collections),
//                 ),
//               );
//             },
//             color: Colors.amber,
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           dividerColor: Colors.black,
//           indicatorColor: Colors.amber,
//           labelColor: Colors.amber,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           unselectedLabelColor: Colors.white,
//           tabs: const [
//             Tab(text: 'All'),
//             Tab(text: 'Movies'),
//             Tab(text: 'Media'),
//           ],
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchData,
//         child: isLoading
//             ? SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     buildCarouselSkeleton(),
//                     buildListViewSkeleton(),
//                   ],
//                 ),
//               )
//             : collections.isEmpty
//                 ? Center(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/icons/no_internet.png',
//                             height: 200,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Connection Issue Detected',
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 16),
//                           Text(
//                             'Please check your\ninternet or Wi-Fi.',
//                             // style: TextStyle(
//                             //   color: Colors.white,
//                             //   fontSize: 18,
//                             // ),
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             '\nIf the issue persists, it may be on\n our end. We are currently working to resolve it.',
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 24),
//                           ElevatedButton(
//                             onPressed: isLoadingApi ? null : fetchData,
//                             child: isLoadingApi
//                                 ? CircularProgressIndicator(
//                                     color: Colors.amber,
//                                   )
//                                 : Text(
//                                     'Retry',
//                                     style: GoogleFonts.firaCode(
//                                       textStyle: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               backgroundColor: Colors.amber,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : TabBarView(
//                     controller: _tabController,
//                     children: [
//                       SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 10),
//                             isLoading ? buildCarouselSkeleton() : buildCarousel(),
//                             const SizedBox(height: 10),
//                             isLoading ? buildListViewSkeleton() : buildListView(),
//                           ],
//                         ),
//                       ),
//                       // Add your content for the "Movies" tab here
//                       SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 10),
//                             isLoading ? buildCarouselSkeleton() : buildCarousel(),
//                             const SizedBox(height: 10),
//                             isLoading ? buildListViewSkeleton() : buildListView(),
//                           ],
//                         ),
//                       ),
//                       // Add your content for the "Media" tab here
//                       Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/icons/Load more-cuate.png',
//                               height: 250,
//                             ),
//                             SizedBox(height: 20,),
//                             Text(
//                               "Coming Soon",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//       bottomNavigationBar: BottomNavigationBarHelper.build(context),
//     );
//   }
//
//   Widget buildCarouselSkeleton() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey,
//       highlightColor: Colors.blueGrey,
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         height: 200,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10.0),
//               width: MediaQuery.of(context).size.width - 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildListViewSkeleton() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey,
//       highlightColor: Colors.blueGrey,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 130,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 250,
//                             height: 90,
//                             color: Colors.grey[300],
//                           ),
//                           const SizedBox(height: 5),
//                           Container(
//                             width: 250,
//                             height: 20,
//                             color: Colors.grey[300],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildCarousel() {
//     final carouselAspectRatio = 16 / 9; // Adjust this ratio as needed
//
//     return CarouselSlider.builder(
//       itemCount: 5,
//       itemBuilder: (BuildContext context, int index, _) {
//         var data = collections[3]['collectionData'][index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => MovieInfoPage(
//                   movieName: data['name'] ?? 'Name in not available ',
//                   description:
//                       data['Description'] ?? 'No Description Availbale ',
//                   poster: data['poster'] ?? 'poster not available ',
//                   videoPath: data['video'] ?? 'Error Loading Video ',
//                   position: 0,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10.0),
//             width: MediaQuery.of(context).size.width - 40,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                 image: NetworkImage(data['poster']),
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//         );
//       },
//       options: CarouselOptions(
//         aspectRatio: carouselAspectRatio, // Use aspectRatio instead of height
//         enableInfiniteScroll: true,
//         autoPlay: true,
//         enlargeCenterPage: true,
//       ),
//     );
//   }
//
//   Widget buildListView() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemCount: collections.length,
//       itemBuilder: (context, index) {
//         var collection = collections[index];
//         var collectionName = collection['collectionName'];
//         if (collectionName == 'featurefilms') {
//           collectionName = "Movies";
//         }
//         var collectionData = collection['collectionData'];
//         Center(
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StreamPage(
//                                 data: collectionData,
//                                 collectionName: collectionName)),
//                       );
//                     },
//                     child: const Text(
//                       'Movies',
//                       style: TextStyle(
//                           backgroundColor: Colors.amber, color: Colors.black),
//                     ))
//               ],
//             ),
//           ),
//         );
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, bottom: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     collectionName.toString().toUpperCase(),
//
//                     style: GoogleFonts.aboreto(
//                       textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     //       fontSize: 15,
//                     //       // fontFamily:,
//                     //       fontWeight: FontWeight.bold,
//                     //       color: Colors.white),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.arrow_right,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StreamPage(
//                                 data: collectionData,
//                                 collectionName: collectionName)),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: collectionData.length,
//                   itemBuilder: (context, index) {
//                     var data = collectionData[index];
//                     return GestureDetector(
//                       onTap: () {
//                         try {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => MovieInfoPage(
//                                 movieName: data['name'] ?? 'No Name Available',
//                                 description: data['Description'] ??
//                                     'No Description available',
//                                 poster: data['poster'] ?? '',
//                                 videoPath: data['video'] ?? '',
//                                 position: 0,
//                               ),
//                             ),
//                           );
//                         } catch (e) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Error'),
//                                 content: const Text(
//                                     'There was an error loading this item.'),
//                                 actions: <Widget>[
//                                   ElevatedButton(
//                                     child: const Text('Report'),
//                                     onPressed: () {
//                                       // Store data in Firestore
//                                       FirebaseFirestore.instance
//                                           .collection('reportedvideos')
//                                           .add({
//                                         'VideoPath': data['video'] ?? '',
//                                         'videoName': data['name'] ?? '',
//                                         'error': e.toString(),
//                                         'timestamp': DateTime.now(),
//                                       });
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                   ElevatedButton(
//                                     child: const Text('OK'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                       },
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(
//                             maxWidth:
//                                 150), // Adjust the maximum width as needed
//                         child: LayoutBuilder(
//                           builder: (BuildContext context,
//                               BoxConstraints constraints) {
//                             final double itemWidth = constraints.maxWidth;
//                             final double itemHeight = itemWidth *
//                                 (9 / 16); // Maintain the 16/9 aspect ratio
//
//                             return Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 10),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Container(
//                                       width: itemWidth,
//                                       height: itemHeight,
//                                       child: Image.network(
//                                         data['poster'],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 7),
//                                 SizedBox(
//                                   width: itemWidth,
//                                   child: Center(
//                                     child: Text(
//                                       data['name'],
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: GoogleFonts.rozhaOne(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           ],
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     title: 'HomePage',
//     home: SafeArea(child: HomePage()),
//   ));
//
// }



///import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rstreamingent/search.dart';
// import 'package:rstreamingent/stream.dart';
// import 'package:shimmer/shimmer.dart';
// import 'movieInfo.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'bottomAppBar/bottomAppBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   List<dynamic> collections = [];
//   bool isLoading = true;
//   bool isLoadingApi = false;
//   late TabController _tabController;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   Future<void> fetchData() async {
//     setState(() {
//       isLoadingApi = true;
//     });
//
//     try {
//       final response = await http.get(Uri.parse('https://appdataapi-production.up.railway.app/'));
//       if (response.statusCode == 200) {
//         setState(() {
//           collections = json.decode(response.body);
//           isLoading = false;
//           isLoadingApi = false;
//           storeDataInSharedPreferences(collections);
//         });
//       } else {
//         final secondResponse = await http.get(Uri.parse('http://appdataapi-production-cca2.up.railway.app'));
//         if (secondResponse.statusCode == 200) {
//           setState(() {
//             collections = json.decode(secondResponse.body);
//             isLoading = false;
//             isLoadingApi = false;
//             storeDataInSharedPreferences(collections);
//           });
//         } else {
//           final cachedData = await getCachedData();
//           if (cachedData.isNotEmpty) {
//             setState(() {
//               collections = cachedData;
//               isLoading = false;
//               isLoadingApi = false;
//             });
//           } else {
//             throw Exception('Failed to load data from both APIs and cache');
//     }
//   }
// }
// } catch (e) {
//       setState(() {
//         isLoading = false;
//         isLoadingApi = false;
//         print('Error: $e');
//       });
//     }
//   }
//
//   Future<void> storeDataInSharedPreferences(List<dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(data);
//     await prefs.setString('cachedData', jsonString);
//   }
//   Future<List<dynamic>> getCachedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('cachedData');
//     print(jsonString);
//     if (jsonString != null) {
//       return jsonDecode(jsonString);
//     }
//     return [];
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leadingWidth: 200,
//         leading: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               width: 10,
//             ),
//             Image.asset(
//               'assets/icons/R-streaming-TEXT-logo.png',
//               height: MediaQuery.of(context).size.height * 0.5,
//             ),
//           ],
//         ),
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SearchPage(collections: collections),
//                 ),
//               );
//             },
//             color: Colors.amber,
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           dividerColor: Colors.black,
//           indicatorColor: Colors.amber,
//           labelColor: Colors.amber,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           unselectedLabelColor: Colors.white,
//           tabs: const [
//             Tab(text: 'All'),
//             Tab(text: 'Movies'),
//             Tab(text: 'Media'),
//           ],
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchData,
//         child: isLoading
//             ? SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     buildCarouselSkeleton(),
//                     buildListViewSkeleton(),
//                   ],
//                 ),
//               )
//             : collections.isEmpty
//                 ? Center(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/icons/no_internet.png',
//                             height: 200,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Connection Issue Detected',
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 16),
//                           Text(
//                             'Please check your\ninternet or Wi-Fi.',
//                             // style: TextStyle(
//                             //   color: Colors.white,
//                             //   fontSize: 18,
//                             // ),
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             '\nIf the issue persists, it may be on\n our end. We are currently working to resolve it.',
//                             style: GoogleFonts.firaCode(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 24),
//                           ElevatedButton(
//                             onPressed: isLoadingApi ? null : fetchData,
//                             child: isLoadingApi
//                                 ? CircularProgressIndicator(
//                                     color: Colors.amber,
//                                   )
//                                 : Text(
//                                     'Retry',
//                                     style: GoogleFonts.firaCode(
//                                       textStyle: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               backgroundColor: Colors.amber,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : TabBarView(
//                     controller: _tabController,
//                     children: [
//                       SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 10),
//                             isLoading ? buildCarouselSkeleton() : buildCarousel(),
//                             const SizedBox(height: 10),
//                             isLoading ? buildListViewSkeleton() : buildListView(),
//                           ],
//                         ),
//                       ),
//                       // Add your content for the "Movies" tab here
//                       SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 10),
//                             isLoading ? buildCarouselSkeleton() : buildCarousel(),
//                             const SizedBox(height: 10),
//                             isLoading ? buildListViewSkeleton() : buildListView(),
//                           ],
//                         ),
//                       ),
//                       // Add your content for the "Media" tab here
//                       Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/icons/Load more-cuate.png',
//                               height: 250,
//                             ),
//                             SizedBox(height: 20,),
//                             Text(
//                               "Coming Soon",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//       bottomNavigationBar: BottomNavigationBarHelper.build(context),
//     );
//   }
//
//   Widget buildCarouselSkeleton() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey,
//       highlightColor: Colors.blueGrey,
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         height: 200,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10.0),
//               width: MediaQuery.of(context).size.width - 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildListViewSkeleton() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey,
//       highlightColor: Colors.blueGrey,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 130,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 250,
//                             height: 90,
//                             color: Colors.grey[300],
//                           ),
//                           const SizedBox(height: 5),
//                           Container(
//                             width: 250,
//                             height: 20,
//                             color: Colors.grey[300],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildCarousel() {
//     final carouselAspectRatio = 16 / 9; // Adjust this ratio as needed
//
//     return CarouselSlider.builder(
//       itemCount: 5,
//       itemBuilder: (BuildContext context, int index, _) {
//         var data = collections[3]['collectionData'][index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => MovieInfoPage(
//                   movieName: data['name'] ?? 'Name in not available ',
//                   description:
//                       data['Description'] ?? 'No Description Availbale ',
//                   poster: data['poster'] ?? 'poster not available ',
//                   videoPath: data['video'] ?? 'Error Loading Video ',
//                   position: 0,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10.0),
//             width: MediaQuery.of(context).size.width - 40,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                 image: NetworkImage(data['poster']),
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//         );
//       },
//       options: CarouselOptions(
//         aspectRatio: carouselAspectRatio, // Use aspectRatio instead of height
//         enableInfiniteScroll: true,
//         autoPlay: true,
//         enlargeCenterPage: true,
//       ),
//     );
//   }
//
//   Widget buildListView() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemCount: collections.length,
//       itemBuilder: (context, index) {
//         var collection = collections[index];
//         var collectionName = collection['collectionName'];
//         if (collectionName == 'featurefilms') {
//           collectionName = "Movies";
//         }
//         var collectionData = collection['collectionData'];
//         Center(
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StreamPage(
//                                 data: collectionData,
//                                 collectionName: collectionName)),
//                       );
//                     },
//                     child: const Text(
//                       'Movies',
//                       style: TextStyle(
//                           backgroundColor: Colors.amber, color: Colors.black),
//                     ))
//               ],
//             ),
//           ),
//         );
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, bottom: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     collectionName.toString().toUpperCase(),
//
//                     style: GoogleFonts.aboreto(
//                       textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     //       fontSize: 15,
//                     //       // fontFamily:,
//                     //       fontWeight: FontWeight.bold,
//                     //       color: Colors.white),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.arrow_right,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StreamPage(
//                                 data: collectionData,
//                                 collectionName: collectionName)),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: collectionData.length,
//                   itemBuilder: (context, index) {
//                     var data = collectionData[index];
//                     return GestureDetector(
//                       onTap: () {
//                         try {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => MovieInfoPage(
//                                 movieName: data['name'] ?? 'No Name Available',
//                                 description: data['Description'] ??
//                                     'No Description available',
//                                 poster: data['poster'] ?? '',
//                                 videoPath: data['video'] ?? '',
//                                 position: 0,
//                               ),
//                             ),
//                           );
//                         } catch (e) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Error'),
//                                 content: const Text(
//                                     'There was an error loading this item.'),
//                                 actions: <Widget>[
//                                   ElevatedButton(
//                                     child: const Text('Report'),
//                                     onPressed: () {
//                                       // Store data in Firestore
//                                       FirebaseFirestore.instance
//                                           .collection('reportedvideos')
//                                           .add({
//                                         'VideoPath': data['video'] ?? '',
//                                         'videoName': data['name'] ?? '',
//                                         'error': e.toString(),
//                                         'timestamp': DateTime.now(),
//                                       });
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                   ElevatedButton(
//                                     child: const Text('OK'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                       },
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(
//                             maxWidth:
//                                 150), // Adjust the maximum width as needed
//                         child: LayoutBuilder(
//                           builder: (BuildContext context,
//                               BoxConstraints constraints) {
//                             final double itemWidth = constraints.maxWidth;
//                             final double itemHeight = itemWidth *
//                                 (9 / 16); // Maintain the 16/9 aspect ratio
//
//                             return Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 10),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Container(
//                                       width: itemWidth,
//                                       height: itemHeight,
//                                       child: Image.network(
//                                         data['poster'],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 7),
//                                 SizedBox(
//                                   width: itemWidth,
//                                   child: Center(
//                                     child: Text(
//                                       data['name'],
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: GoogleFonts.rozhaOne(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           ],
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     title: 'HomePage',
//     home: SafeArea(child: HomePage()),
//   ));
//
// }
