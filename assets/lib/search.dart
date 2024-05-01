import 'package:flutter/material.dart';
import 'movieInfo.dart';
import 'bottomAppBar/bottomAppBar.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> collections;

  const SearchPage({Key? key, required this.collections}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  void searchMovies(String query) {
    List<dynamic> results = [];
    for (var collection in widget.collections) {
      for (var movie in collection['collectionData']) {
        if (movie['name'].toLowerCase().contains(query.toLowerCase())) {
          results.add(movie);
        }
      }
    }
    setState(() {
      searchResults = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Search',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                label: Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                searchMovies(value);
              },
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: _searchController.text.isNotEmpty && searchResults.isEmpty
                ? Center(
              child: Text(
                'No results found',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var movie = searchResults[index];
                return ListTile(
                  title: Text(
                    movie['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MovieInfoPage(
                          movieName: movie['name'],
                          description: movie['Description'],
                          poster: movie['poster'],
                          videoPath: movie['video'],
                          position: 0,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarHelper.build(context),
    );
  }
}
