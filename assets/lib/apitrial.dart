import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movieInfo.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> collections = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://appdataapi-production.up.railway.app/'));

    if (response.statusCode == 200) {
      setState(() {
        collections = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyApp'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          var collection = collections[index];
          var collectionName = collection['collectionName'];
          var collectionData = collection['collectionData'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  collectionName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 200, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: collectionData.length,
                  itemBuilder: (context, index) {
                    var data = collectionData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>MovieInfoPage(
                                movieName: data['name'],
                                description: data['Description'],
                                poster: data['poster'],
                                videoPath:  data['video'],
                                position: 0)

                            //     MovieInfoPage(
                            //   movieName: data['name'],
                            //   description: data['Description'],
                            //   poster: data['poster'],
                            //   videoPath: data['video'],
                            //   position: 0,
                            // ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 160,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  data['poster'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            data['name'],
                            style: TextStyle(
                              color: Colors.black,
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
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    title: 'MyApp',
    home: MyApp(),
  ));
}
