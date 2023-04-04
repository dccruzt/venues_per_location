import 'package:shared_preferences/shared_preferences.dart';

class VenuesLocalDataSource {
  static const _favoriteVenues = 'FAVORITE_VENUES';

  Future<void> setFavoriteVenue({
    required String id,
    required bool isFavorite,
  }) async {
    try {
      final favorites = await getFavoriteVenues();
      if (isFavorite && !favorites.contains(id)) {
        favorites.add(id);
      } else if (!isFavorite && favorites.contains(id)) {
        favorites.remove(id);
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(_favoriteVenues, favorites);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<String>> getFavoriteVenues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_favoriteVenues) ?? [];
    } catch (_) {
      rethrow;
    }
  }
}
