class FavoritesUtil {
  static List<Map<String, String>> favorites = [];

  static void addToFavorites(String movieName, String poster, String description) {
    // Check if the item already exists in favorites
    bool alreadyExists = favorites.any((element) => element['movieName'] == movieName);

    if (!alreadyExists) {
      favorites.add({'movieName': movieName, 'poster': poster,'description':description});
    }
  }

  static void removeFromFavorites(String movieName) {
    favorites.removeWhere((element) => element['movieName'] == movieName);
  }
}
