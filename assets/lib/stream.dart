import 'package:flutter/material.dart';

import 'bottomAppBar/bottomAppBar.dart';
import 'movieInfo.dart';

class StreamPage extends StatelessWidget {
  final List<dynamic> data;
  final String collectionName;

  StreamPage({required this.data, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    final isMobileView = MediaQuery.of(context).size.width < 600;
    final crossAxisCount = isMobileView ? 3 : 5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(collectionName.toUpperCase(), style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false
        ,
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          var item = data[index];
          return GestureDetector(
            onTap: () {
              // Handle item tap if needed
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieInfoPage(
                    movieName: item['name'],
                    description: item['Description'],
                    poster: item['poster'],
                    videoPath: item['video'],
                    position: 0,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        item['poster'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarHelper.build(context),
    );
  }
}
