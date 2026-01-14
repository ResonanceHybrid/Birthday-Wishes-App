import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_colors.dart';

/// Bottom sheet for selecting backgrounds (gradients, solid colors, or custom image)
class BackgroundSelector extends StatelessWidget {
  final int selectedGradientIndex;
  final int selectedSolidIndex;
  final String? customImagePath;
  final Function(int) onGradientSelected;
  final Function(int) onSolidSelected;
  final Function(String) onImageSelected;

  const BackgroundSelector({
    super.key,
    required this.selectedGradientIndex,
    required this.selectedSolidIndex,
    required this.customImagePath,
    required this.onGradientSelected,
    required this.onSolidSelected,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'پس منظر منتخب کریں',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          
          // Gradient Backgrounds Section
          _buildSectionTitle('گریڈیئنٹ'),
          const SizedBox(height: 8),
          _buildGradientGrid(),
          const SizedBox(height: 16),
          
          // Solid Colors Section
          _buildSectionTitle('سادہ رنگ'),
          const SizedBox(height: 8),
          _buildSolidColorGrid(),
          const SizedBox(height: 16),
          
          // Upload Image Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('اپنی تصویر اپ لوڈ کریں'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientGrid() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppColors.backgroundGradients.length,
        itemBuilder: (context, index) {
          final isSelected = selectedGradientIndex == index && customImagePath == null;
          return GestureDetector(
            onTap: () => onGradientSelected(index),
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.backgroundGradients[index],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 3)
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 24)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSolidColorGrid() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppColors.solidBackgrounds.length,
        itemBuilder: (context, index) {
          final isSelected = selectedSolidIndex == index && 
                            selectedGradientIndex == -1 && 
                            customImagePath == null;
          return GestureDetector(
            onTap: () => onSolidSelected(index),
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.solidBackgrounds[index],
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 3)
                    : Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary, size: 24)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      onImageSelected(image.path);
      Navigator.pop(context);
    }
  }
}
