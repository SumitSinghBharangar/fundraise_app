import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/app_logo_widget.dart';
import './widgets/login_form_widget.dart';
import './widgets/sign_up_link_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@fundraise.com': 'admin123',
    'intern@fundraise.com': 'intern123',
    'manager@fundraise.com': 'manager123',
  };

  void _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    // Mock authentication delay
    await Future.delayed(const Duration(seconds: 1));

    // Check mock credentials
    if (_mockCredentials.containsKey(email.toLowerCase()) &&
        _mockCredentials[email.toLowerCase()] == password) {
      // Success - provide haptic feedback
      HapticFeedback.lightImpact();

      // Navigate to dashboard
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard-screen');
      }
    } else {
      // Error - show specific message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid credentials. Please check your email and password.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Dismiss keyboard when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 8.h),

                      // App Logo Section
                      const AppLogoWidget(),

                      SizedBox(height: 6.h),

                      // Welcome Text
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 1.h),

                      Text(
                        'Sign in to continue your fundraising journey',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 4.h),

                      // Login Form
                      LoginFormWidget(
                        onLogin: _handleLogin,
                        isLoading: _isLoading,
                      ),

                      SizedBox(height: 4.h),

                      // Social Login Options
                      const SocialLoginWidget(),

                      const Spacer(),

                      // Sign Up Link
                      const SignUpLinkWidget(),

                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
