import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/custom_text_field.dart';
import './widgets/password_strength_indicator.dart';
import './widgets/profile_photo_section.dart';
import './widgets/terms_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _organizationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form state
  XFile? _selectedImage;
  bool _isTermsAccepted = false;
  bool _isLoading = false;
  bool _isFormValid = false;

  // Animation controllers
  late AnimationController _successAnimationController;
  late Animation<double> _successScaleAnimation;
  late Animation<double> _successOpacityAnimation;

  // Mock existing users data for validation
  final List<Map<String, String>> _existingUsers = [
    {"email": "john.doe@example.com", "phone": "+91 9876543210"},
    {"email": "sarah.wilson@college.edu", "phone": "+91 8765432109"},
    {"email": "mike.johnson@university.ac.in", "phone": "+91 7654321098"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupFormListeners();
  }

  void _initializeAnimations() {
    _successAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _successScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _successAnimationController,
      curve: Curves.elasticOut,
    ));

    _successOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _successAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _setupFormListeners() {
    _fullNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _organizationController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _phoneController.text.isNotEmpty &&
        _isValidPhone(_phoneController.text) &&
        _organizationController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isStrongPassword(_passwordController.text) &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text &&
        _isTermsAccepted;

    setState(() {
      _isFormValid = isValid;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+91\s[6-9]\d{9}$').hasMatch(phone);
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    // Check if email already exists
    final existingUser = _existingUsers.firstWhere(
      (user) => user['email'] == value,
      orElse: () => {},
    );
    if (existingUser.isNotEmpty) {
      return 'This email is already registered';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!_isValidPhone(value)) {
      return 'Please enter a valid Indian phone number (+91 XXXXXXXXXX)';
    }
    // Check if phone already exists
    final existingUser = _existingUsers.firstWhere(
      (user) => user['phone'] == value,
      orElse: () => {},
    );
    if (existingUser.isNotEmpty) {
      return 'This phone number is already registered';
    }
    return null;
  }

  String? _validateOrganization(String? value) {
    if (value == null || value.isEmpty) {
      return 'Organization/College is required';
    }
    if (value.length < 3) {
      return 'Organization name must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!_isStrongPassword(value)) {
      return 'Password must be at least 8 characters with uppercase, lowercase, numbers and symbols';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate() || !_isFormValid) {
      _showErrorSnackBar('Please fill all required fields correctly');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success animation
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _successAnimationController.forward();

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _successAnimationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _successScaleAnimation.value,
                      child: Opacity(
                        opacity: _successOpacityAnimation.value,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 10.w,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 3.h),
                Text(
                  'Welcome to FundRaise Portal!',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Your account has been created successfully. You can now start your fundraising journey and track your progress.',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(
                          context, '/dashboard-screen');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  @override
  void dispose() {
    _successAnimationController.dispose();
    _scrollController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _organizationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back_ios',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 6.w,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/login-screen'),
        ),
        title: Text(
          'Create Account',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Text(
                  'Join FundRaise Portal',
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Create your account to start your fundraising journey and make a difference in your community.',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),

                // Profile Photo Section
                Center(
                  child: ProfilePhotoSection(
                    onImageSelected: (XFile? image) {
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                  ),
                ),
                SizedBox(height: 4.h),

                // Form Fields
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  iconName: 'person',
                  controller: _fullNameController,
                  validator: _validateFullName,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),

                CustomTextField(
                  label: 'Email Address',
                  hint: 'Enter your email address',
                  iconName: 'email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),

                CustomTextField(
                  label: 'Phone Number',
                  hint: '+91 XXXXXXXXXX',
                  iconName: 'phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\s\+]')),
                    LengthLimitingTextInputFormatter(14),
                  ],
                ),
                SizedBox(height: 3.h),

                CustomTextField(
                  label: 'Organization/College',
                  hint: 'Enter your organization or college name',
                  iconName: 'business',
                  controller: _organizationController,
                  validator: _validateOrganization,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),

                CustomTextField(
                  label: 'Password',
                  hint: 'Create a strong password',
                  iconName: 'lock',
                  controller: _passwordController,
                  isPassword: true,
                  validator: _validatePassword,
                  textInputAction: TextInputAction.next,
                ),
                PasswordStrengthIndicator(password: _passwordController.text),
                SizedBox(height: 3.h),

                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  iconName: 'lock_outline',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: _validateConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    if (_isFormValid) {
                      _handleSignUp();
                    }
                  },
                ),
                SizedBox(height: 4.h),

                // Terms and Conditions
                TermsCheckbox(
                  isChecked: _isTermsAccepted,
                  onChanged: (bool value) {
                    setState(() {
                      _isTermsAccepted = value;
                    });
                    _validateForm();
                  },
                ),
                SizedBox(height: 4.h),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isFormValid && !_isLoading ? _handleSignUp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: _isFormValid ? 2 : 0,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 5.w,
                            width: 5.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Create Account',
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 3.h),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                          context, '/login-screen'),
                      child: Text(
                        'Sign In',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
