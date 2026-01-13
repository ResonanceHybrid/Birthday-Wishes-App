import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Font selector widget for choosing text style
class FontSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onFontSelected;

  const FontSelector({
    super.key,
    required this.selectedIndex,
    required this.onFontSelected,
  });

  static const List<String> fontNames = [
    'Poppins',
    'Dancing Script',
    'Playfair Display',
    'Roboto',
    'Pacifico',
    'Montserrat',
  ];

  static TextStyle getFontStyle(int index, {double fontSize = 18, Color color = Colors.black}) {
    switch (index) {
      case 0:
        return GoogleFonts.poppins(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
      case 1:
        return GoogleFonts.dancingScript(fontSize: fontSize, color: color, fontWeight: FontWeight.w600);
      case 2:
        return GoogleFonts.playfairDisplay(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
      case 3:
        return GoogleFonts.roboto(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
      case 4:
        return GoogleFonts.pacifico(fontSize: fontSize, color: color);
      case 5:
        return GoogleFonts.montserrat(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
      default:
        return GoogleFonts.poppins(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fontNames.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onFontSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(22),
                border: isSelected 
                    ? null 
                    : Border.all(color: AppColors.textLight.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Text(
                  fontNames[index],
                  style: getFontStyle(
                    index,
                    fontSize: 14,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
