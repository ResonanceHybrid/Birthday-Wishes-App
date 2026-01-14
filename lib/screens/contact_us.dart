import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

/// Contact Us screen
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _openUrl(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // fallback: do nothing (or show snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = 'Sandipvai4456@gmail.com'; // ✅ change this
    //final website = 'https://birthdaywishes.app'; // ✅ change this
    final subject = Uri.encodeComponent('سپورٹ - سالگرہ مبارک ایپ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('رابطہ کریں'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Header Icon
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.support_agent,
                size: 46,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'رابطہ کریں',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'ہم عموماً 24-48 گھنٹوں میں جواب دیتے ہیں۔',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),

            const SizedBox(height: 28),

            // Info box
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'اگر آپ کے کوئی سوالات، رائے یا مسائل ہیں تو ہم سے رابطہ کریں۔ براہ کرم فوری مدد کے لیے اپنے فون کا ماڈل اور اینڈرائڈ ورژن شامل کریں۔',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
              ),
            ),

            const SizedBox(height: 22),

            // Contact cards
            _contactTile(
              context,
              icon: Icons.email_outlined,
              title: 'ای میل سپورٹ',
              subtitle: email,
              onTap: () => _openUrl(
                Uri.parse('mailto:$email?subject=$subject'),
              ),
            ),

            // _contactTile(
            //   context,
            //   icon: Icons.language,
            //   title: 'Website',
            //   subtitle: website,
            //   onTap: () => _openUrl(Uri.parse(website)),
            // ),

            _contactTile(
              context,
              icon: Icons.bug_report_outlined,
              title: 'بگ رپورٹ کریں',
              subtitle: 'تفصیلات اور اسکرین شاٹ بھیجیں',
              onTap: () => _openUrl(
                Uri.parse(
                  'mailto:$email?subject=${Uri.encodeComponent('بگ رپورٹ - سالگرہ مبارک')}',
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'محبت سے بنایا گیا ❤️',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.18),
            ),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
