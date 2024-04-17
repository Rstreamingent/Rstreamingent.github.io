import 'package:flutter/material.dart';
import 'favorites_utils.dart';
import 'home.dart';
import 'bottomAppBar/bottomAppBar.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<bool> onWillPop(BuildContext context) async {
    // Navigate to HomePage and clear navigation stack
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => onWillPop(context),
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FavoritesUtil.favorites.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'It\'s empty here',
              style: TextStyle(fontSize: 20,color: Colors.white70,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            TextButton(
              onPressed: () {
                BottomNavigationBarHelper.setIndex(0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Go to Home',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: FavoritesUtil.favorites.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Add onTap functionality if needed
            },
            child: Container(padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xff161a25), // Dark background color
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: ListTile(

                title: Row(
                  children: [
                    Expanded(
                      child: Text(FavoritesUtil.favorites[index]['movieName'] ?? '', style: TextStyle(color: Colors.white),),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite,color: Colors.red,),
                      onPressed: () {
                        // Remove the item from favorites upon clicking the button
                        String? movieName = FavoritesUtil.favorites[index]['movieName'];
                        FavoritesUtil.removeFromFavorites(movieName!);
                        // Trigger a rebuild of the widget after removing an item
                        setState(() {});
                      },
                    ),
                  ],
                ),
                leading: Image.network(
                  FavoritesUtil.favorites[index]['poster'] ?? '',
                  width: 120,
                  height: 90,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarHelper.build(context),
    )
    );
  }
}
