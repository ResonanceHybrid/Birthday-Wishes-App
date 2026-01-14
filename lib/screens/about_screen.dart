import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// About screen with app info
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ہمارے بارے میں'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // App Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Text(
                '🎂',
                style: TextStyle(fontSize: 64),
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'سالگرہ مبارک',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'ورژن 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            // Description
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'سالگرہ مبارک ایپ آپ کے پیاروں کے لیے خوبصورت اور ذاتی سالگرہ پیغامات بنانے میں مدد کرتی ہے۔ مختلف زمروں میں سے منتخب کریں، مختلف فونٹس اور رنگوں سے متن کو ترتیب دیں، شاندار پس مناظر شامل کریں اور اپنی تخلیقات شیئر کریں!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
              ),
            ),
            const SizedBox(height: 32),
            // Features
            _buildFeatureItem(
              context,
              icon: Icons.category,
              title: '10 زمرے',
              description: 'مزاحیہ، رومانوی، خاندانی، دوست اور حوصلہ افزا',
            ),
            _buildFeatureItem(
              context,
              icon: Icons.text_fields,
              title: 'خوبصورت فونٹس',
              description: '6 خوبصورت فونٹ اسٹائلز میں سے منتخب کریں',
            ),
            _buildFeatureItem(
              context,
              icon: Icons.palette,
              title: 'شاندار پس مناظر',
              description: 'گریڈیئنٹ، سادہ رنگ، یا اپنی تصاویر',
            ),
            _buildFeatureItem(
              context,
              icon: Icons.download,
              title: 'ڈاؤن لوڈ اور شیئر',
              description: 'اپنے پیغامات تصویر کے طور پر محفوظ کریں',
            ),
            const SizedBox(height: 32),
            // Developer Info
            Text(
              'محبت سے بنایا گیا ❤️',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
