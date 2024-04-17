import 'dart:async';

class FavoritesUtil {
  static List<Map<String, String>> favorites = [];

  static void addToFavorites(String movieName, String poster) {
    favorites.add({'movieName': movieName, 'poster': poster});
  }

  static void removeFromFavorites(String movieName) {
    favorites.removeWhere((element) => element['movieName'] == movieName);
  }
}
