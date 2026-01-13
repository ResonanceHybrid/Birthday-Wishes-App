import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Service to manage favorite wishes locally
class FavoritesService {
  static const String _favoritesKey = 'favorite_wishes';

  /// Get all favorite wish IDs
  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson == null) return {};
    
    final List<dynamic> favoritesList = json.decode(favoritesJson);
    return favoritesList.map((e) => e.toString()).toSet();
  }

  /// Check if a wish is favorited
  static Future<bool> isFavorite(String wishId) async {
    final favorites = await getFavorites();
    return favorites.contains(wishId);
  }

  /// Add a wish to favorites
  static Future<void> addFavorite(String wishId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(wishId);
    await prefs.setString(_favoritesKey, json.encode(favorites.toList()));
  }

  /// Remove a wish from favorites
  static Future<void> removeFavorite(String wishId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(wishId);
    await prefs.setString(_favoritesKey, json.encode(favorites.toList()));
  }

  /// Toggle favorite status
  static Future<bool> toggleFavorite(String wishId) async {
    final isFav = await isFavorite(wishId);
    if (isFav) {
      await removeFavorite(wishId);
      return false;
    } else {
      await addFavorite(wishId);
      return true;
    }
  }

  /// Clear all favorites
  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}
