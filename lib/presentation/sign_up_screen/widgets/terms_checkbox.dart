import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TermsCheckbox extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const TermsCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Terms and Conditions',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FundRaise Portal Terms of Service',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildTermsSection(
                  'Account Registration',
                  'By creating an account, you agree to provide accurate information and maintain the security of your login credentials.',
                ),
                _buildTermsSection(
                  'Fundraising Activities',
                  'All fundraising activities must comply with local laws and organizational guidelines. Misrepresentation of funds or causes is strictly prohibited.',
                ),
                _buildTermsSection(
                  'Data Privacy',
                  'We collect and process your personal information in accordance with our Privacy Policy. Your data is used solely for platform functionality and performance tracking.',
                ),
                _buildTermsSection(
                  'User Conduct',
                  'Users must maintain professional conduct, respect fellow interns, and follow all organizational policies during fundraising activities.',
                ),
                _buildTermsSection(
                  'Rewards and Recognition',
                  'Rewards are based on verified donation collections. The organization reserves the right to modify reward criteria and dispute any fraudulent activities.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTermsSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            content,
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Privacy Policy',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FundRaise Portal Privacy Policy',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildPrivacySection(
                  'Information We Collect',
                  'We collect personal information including name, email, phone number, and fundraising performance data to provide platform services.',
                ),
                _buildPrivacySection(
                  'How We Use Your Information',
                  'Your information is used for account management, performance tracking, leaderboard rankings, and communication about fundraising activities.',
                ),
                _buildPrivacySection(
                  'Data Security',
                  'We implement industry-standard security measures to protect your personal information from unauthorized access or disclosure.',
                ),
                _buildPrivacySection(
                  'Information Sharing',
                  'We do not sell or share your personal information with third parties except as required for platform functionality or legal compliance.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPrivacySection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            content,
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: widget.isChecked,
            onChanged: (bool? value) {
              widget.onChanged(value ?? false);
            },
            activeColor: AppTheme.lightTheme.colorScheme.primary,
            checkColor: Colors.white,
            side: BorderSide(
              color: widget.isChecked
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.outline,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: RichText(
              text: TextSpan(
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _showTermsDialog,
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _showPrivacyDialog,
                  ),
                  TextSpan(
                    text: ' of FundRaise Portal.',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
