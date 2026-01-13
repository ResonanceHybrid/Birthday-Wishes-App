import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Privacy Policy screen (required for Play Store)
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: January 2026',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'Introduction',
              content:
                  'Welcome to Birthday Wishes. We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we handle your information when you use our app.',
            ),
            _buildSection(
              context,
              title: 'Information We Collect',
              content:
                  'Birthday Wishes is designed with privacy in mind. We do not collect, store, or transmit any personal information. All your data remains on your device:\n\n'
                  '• Favorite wishes are stored locally on your device\n'
                  '• Custom images you use are not uploaded anywhere\n'
                  '• We do not track your usage or behavior',
            ),
            _buildSection(
              context,
              title: 'Permissions',
              content:
                  'The app may request the following permissions:\n\n'
                  '• Storage/Photos: To save your created birthday wish images to your gallery\n'
                  '• Camera Roll/Gallery: To allow you to select custom background images\n\n'
                  'These permissions are only used for the stated purposes and no data is transmitted.',
            ),
            _buildSection(
              context,
              title: 'Third-Party Services',
              content:
                  'Birthday Wishes does not integrate with third-party analytics, advertising, or tracking services. Your usage of the app is completely private.',
            ),
            _buildSection(
              context,
              title: 'Data Sharing',
              content:
                  'We do not share any data with third parties. When you use the share feature, you are using your device\'s native sharing capabilities, and we have no access to what you share or with whom.',
            ),
            _buildSection(
              context,
              title: 'Children\'s Privacy',
              content:
                  'Birthday Wishes is suitable for users of all ages. We do not knowingly collect any information from children or any users.',
            ),
            _buildSection(
              context,
              title: 'Changes to This Policy',
              content:
                  'We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page and updating the "Last updated" date.',
            ),
            _buildSection(
              context,
              title: 'Contact Us',
              content:
                  'If you have any questions about this Privacy Policy, please contact us through the app store listing.',
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
                      'Your privacy is important to us. This app operates entirely offline and respects your data.',
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
