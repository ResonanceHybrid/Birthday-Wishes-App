import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category.dart';
import '../models/wish.dart';

/// Service to load wishes and categories from local JSON assets
class WishDataLoader {
  static Future<Map<String, dynamic>> _loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/data/wishes.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  /// Load all categories from the JSON file
  static Future<List<Category>> loadCategories() async {
    final data = await _loadJsonData();
    final categoriesJson = data['categories'] as List<dynamic>;
    return categoriesJson
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Load all wishes from the JSON file
  static Future<List<Wish>> loadAllWishes() async {
    final data = await _loadJsonData();
    final wishesJson = data['wishes'] as List<dynamic>;
    return wishesJson
        .map((json) => Wish.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Load wishes for a specific category
  static Future<List<Wish>> loadWishesByCategory(String categoryId) async {
    final allWishes = await loadAllWishes();
    return allWishes.where((wish) => wish.categoryId == categoryId).toList();
  }

  /// Get a single category by ID
  static Future<Category?> getCategoryById(String categoryId) async {
    final categories = await loadCategories();
    try {
      return categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}
