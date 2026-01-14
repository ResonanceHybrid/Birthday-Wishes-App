import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Privacy Policy screen (required for Play Store)
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رازداری پالیسی')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رازداری پالیسی',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'آخری ترمیم: جنوری 2026',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'تعارف',
              content:
                  'سالگرہ مبارک ایپ میں خوش آمدید۔ ہم آپ کی رازداری کا احترام کرتے ہیں اور آپ کے ذاتی ڈیٹا کی حفاظت کے پابند ہیں۔ یہ رازداری پالیسی بتاتی ہے کہ جب آپ ہماری ایپ استعمال کرتے ہیں تو ہم آپ کی معلومات کو کیسے سنبھالتے ہیں۔',
            ),
            _buildSection(
              context,
              title: 'ہم کیا معلومات جمع کرتے ہیں',
              content:
                  'سالگرہ مبارک رازداری کو مد نظر رکھ کر بنایا گیا ہے۔ ہم کوئی ذاتی معلومات جمع، ذخیرہ یا منتقل نہیں کرتے۔ آپ کا تمام ڈیٹا آپ کے فون پر رہتا ہے:\n\n'
                  '• پسندیدہ پیغامات آپ کے فون پر محفوظ رہتے ہیں\n'
                  '• آپ کی تصاویر کہیں اپ لوڈ نہیں ہوتیں\n'
                  '• ہم آپ کے استعمال کو ٹریک نہیں کرتے',
            ),
            _buildSection(
              context,
              title: 'اجازتیں',
              content:
                  'ایپ مندرجہ ذیل اجازتیں مانگ سکتی ہے:\n\n'
                  '• سٹوریج/فوٹوز: آپ کی سالگرہ کی تصویریں گیلری میں محفوظ کرنے کے لیے\n'
                  '• کیمرہ رول/گیلری: پس منظر تصویر منتخب کرنے کے لیے\n\n'
                  'یہ اجازتیں صرف بیان کردہ مقاصد کے لیے استعمال ہوتی ہیں۔',
            ),
            _buildSection(
              context,
              title: 'فریق ثالث کی خدمات',
              content:
                  'سالگرہ مبارک فریق ثالث کے تجزیات، اشتہارات یا ٹریکنگ سروسز کے ساتھ مربوط نہیں ہے۔ آپ کا ایپ استعمال مکمل طور پر نجی ہے۔',
            ),
            _buildSection(
              context,
              title: 'ڈیٹا شیئرنگ',
              content:
                  'ہم کسی بھی فریق ثالث کے ساتھ کوئی ڈیٹا شیئر نہیں کرتے۔ جب آپ شیئر فیچر استعمال کرتے ہیں تو آپ اپنے فون کی مقامی شیئرنگ استعمال کر رہے ہیں۔',
            ),
            _buildSection(
              context,
              title: 'بچوں کی رازداری',
              content:
                  'سالگرہ مبارک تمام عمروں کے صارفین کے لیے موزوں ہے۔ ہم بچوں یا کسی بھی صارف سے کوئی معلومات جمع نہیں کرتے۔',
            ),
            _buildSection(
              context,
              title: 'پالیسی میں تبدیلیاں',
              content:
                  'ہم وقتاً فوقتاً اس رازداری پالیسی کو اپ ڈیٹ کر سکتے ہیں۔ ہم آپ کو اس صفحے پر نئی پالیسی شائع کر کے مطلع کریں گے۔',
            ),
            _buildSection(
              context,
              title: 'رابطہ کریں',
              content:
                  'اگر اس رازداری پالیسی کے بارے میں کوئی سوال ہو تو ایپ سٹور لسٹنگ کے ذریعے ہم سے رابطہ کریں۔',
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified_user, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'آپ کی رازداری ہمارے لیے اہم ہے۔ یہ ایپ مکمل طور پر آف لائن کام کرتی ہے اور آپ کے ڈیٹا کا احترام کرتی ہے۔',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
