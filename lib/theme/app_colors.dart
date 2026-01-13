import 'package:flutter/material.dart';

/// App color palette - pastel colors for a modern, minimal look
class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4A42D4);

  // Background Colors
  static const Color background = Color(0xFFF8F9FE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F1F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Category Colors (Pastel)
  static const Color funny = Color(0xFFFFE066);
  static const Color romantic = Color(0xFFFF6B9D);
  static const Color family = Color(0xFF6BCB77);
  static const Color friend = Color(0xFF4D96FF);
  static const Color inspirational = Color(0xFFC9A7EB);

  // Accent Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradient Collections
  static const List<List<Color>> backgroundGradients = [
    [Color(0xFFFF9A8B), Color(0xFFFF6A88), Color(0xFFFF99AC)],
    [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
    [Color(0xFFD299C2), Color(0xFFFEF9D7)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFFFDCB82), Color(0xFFF97B8C)],
    [Color(0xFF6DD5FA), Color(0xFF2980B9)],
    [Color(0xFFFFE985), Color(0xFFFA742B)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
    [Color(0xFFFCE38A), Color(0xFFF38181)],
    [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
  ];

  // Solid Background Colors
  static const List<Color> solidBackgrounds = [
    Color(0xFFFFF5F5), // Light Pink
    Color(0xFFF0FFF4), // Light Green
    Color(0xFFF0F4FF), // Light Blue
    Color(0xFFFFFBEB), // Light Yellow
    Color(0xFFFAF5FF), // Light Purple
    Color(0xFFF5FFFA), // Mint
    Color(0xFFFFF0F5), // Lavender Blush
    Color(0xFFE6FFFA), // Light Cyan
  ];

  // Get category color by ID
  static Color getCategoryColor(String categoryId) {
    switch (categoryId) {
      case 'funny':
        return funny;
      case 'romantic':
        return romantic;
      case 'family':
        return family;
      case 'friend':
        return friend;
      case 'inspirational':
        return inspirational;
      default:
        return primary;
    }
  }
}
