import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rstreamingent/search.dart';
import 'package:rstreamingent/stream.dart';
import 'package:shimmer/shimmer.dart';
import 'movieInfo.dart';

import 'bottomAppBar/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<dynamic> collections = [];
  bool isLoading = true;
  late TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://appdataapi-production.up.railway.app/'));

    if (response.statusCode == 200) {
      setState(() {
        collections = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/icons/R-streaming-TEXT-logo.png',
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(collections: collections),
                ),
              );
            },
            color: Colors.amber,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.black,
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Movies'),
            Tab(text: 'Media'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                isLoading ? buildCarouselSkeleton() : buildCarousel(),
                const SizedBox(height: 10),
                isLoading ? buildListViewSkeleton() : buildListView(),
              ],
            ),
          ),
          // Add your content for the "Movies" tab here
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                isLoading ? buildCarouselSkeleton() : buildCarousel(),
                const SizedBox(height: 10),
                isLoading ? buildListViewSkeleton() : buildListView(),
              ],
            ),
          ),
          // Add your content for the "Media" tab here
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarHelper.build(context),
    );
  }

  Widget buildCarouselSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.blueGrey,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListViewSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.blueGrey,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 90,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 250,
                            height: 20,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCarousel() {
    final isWebView =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    final carouselHeight = isWebView ? 600.0 : 200.0;

    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index, _) {
        var data = collections[1]['collectionData'][index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieInfoPage(
                  movieName: data['name']?? 'Name in not available ',
                  description: data['Description']?? 'No Description Availbale ',
                  poster: data['poster']?? 'poster not available ',
                  videoPath: data['video']?? 'Error Loading Video ',
                  position: 0,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width - 40,
            height: carouselHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(data['poster']),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: carouselHeight,
        aspectRatio: MediaQuery.of(context).size.width / 1.67,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    collectionName.toString().toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
              height: 180,
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
                                description: data['Description'] ?? 'No Description available',
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
                                content: const Text('There was an error loading this item.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Report'),
                                    onPressed: () {
                                      // Store data in Firestore
                                      FirebaseFirestore.instance.collection('reportedvideos').add({
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

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            width: 250,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                data['poster'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          data['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'HomePage',
    home: SafeArea(child: HomePage()),
  ));
}
