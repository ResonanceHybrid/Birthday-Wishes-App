import 'package:flutter/material.dart';
import 'dart:io';
import '../theme/app_colors.dart';
import 'font_selector.dart';

/// Reusable widget for the wish preview with RepaintBoundary for image capture
class WishPreview extends StatelessWidget {
  final GlobalKey repaintBoundaryKey;
  final String text;
  final int fontIndex;
  final Color textColor;
  final int gradientIndex;
  final int solidIndex;
  final String? customImagePath;
  final double fontSize;
  final TextAlign textAlign;

  const WishPreview({
    super.key,
    required this.repaintBoundaryKey,
    required this.text,
    required this.fontIndex,
    required this.textColor,
    required this.gradientIndex,
    required this.solidIndex,
    this.customImagePath,
    this.fontSize = 24,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintBoundaryKey,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 300),
        decoration: _buildDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              text,
              textAlign: textAlign,
              style: FontSelector.getFontStyle(
                fontIndex,
                fontSize: fontSize,
                color: textColor,
              ).copyWith(
                height: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    // Custom image background
    if (customImagePath != null && customImagePath!.isNotEmpty) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: FileImage(File(customImagePath!)),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.1),
            BlendMode.darken,
          ),
        ),
      );
    }

    // Gradient background
    if (gradientIndex >= 0 && gradientIndex < AppColors.backgroundGradients.length) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: AppColors.backgroundGradients[gradientIndex],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }

    // Solid color background
    if (solidIndex >= 0 && solidIndex < AppColors.solidBackgrounds.length) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.solidBackgrounds[solidIndex],
      );
    }

    // Default gradient
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: AppColors.backgroundGradients[0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
