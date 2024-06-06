import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavoritesUtil {
  static Future<void> initialize() async {
    // Get a reference to shared preferences
    prefs = await SharedPreferences.getInstance();
    // Load existing favorites from shared preferences
    final encodedFavorites = prefs?.getStringList('favorites');
    if (encodedFavorites != null) {
      favorites = encodedFavorites.map((encodedMap) {
        // Cast the decoded value to a Map<String, String>
        return encodedMap as Map<String, String>;
      }).toList();
    }
  }

  static List<Map<String, String>> favorites = [];
  static SharedPreferences? prefs;

  static Future<void> addToFavorites(String movieName, String poster, String description) async {
    // Check if the item already exists in favorites
    bool alreadyExists = favorites.any((element) => element['movieName'] == movieName);

    if (!alreadyExists) {
      favorites.add({'movieName': movieName, 'poster': poster, 'description': description});
      // Save updated favorites to shared preferences
      await saveFavorites();
    }
  }

  static Future<void> removeFromFavorites(String movieName) async {
    favorites.removeWhere((element) => element['movieName'] == movieName);
    // Save updated favorites to shared preferences
    await saveFavorites();
  }

  static Future<void> saveFavorites() async {
    if (prefs == null) {
      // Ensure preferences are initialized before saving
      await initialize();
    }
    final encodedFavorites = favorites.map((movie) => jsonEncode(movie)).toList();
    await prefs!.setStringList('favorites', encodedFavorites);
  }
}
