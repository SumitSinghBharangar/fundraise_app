import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DonationStatsWidget extends StatefulWidget {
  final double totalDonations;
  final double monthlyGoal;
  final double progressPercentage;

  const DonationStatsWidget({
    Key? key,
    required this.totalDonations,
    required this.monthlyGoal,
    required this.progressPercentage,
  }) : super(key: key);

  @override
  State<DonationStatsWidget> createState() => _DonationStatsWidgetState();
}

class _DonationStatsWidgetState extends State<DonationStatsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _countAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progressPercentage / 100,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _countAnimation = Tween<double>(
      begin: 0.0,
      end: widget.totalDonations,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Donations Raised',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomIconWidget(
                iconName: 'trending_up',
                color: AppTheme.successLight,
                size: 5.w,
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Animated Counter
          AnimatedBuilder(
            animation: _countAnimation,
            builder: (context, child) {
              return Text(
                '₹${_formatCurrency(_countAnimation.value)}',
                style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),

          SizedBox(height: 3.h),

          // Progress Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Goal Progress',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${widget.progressPercentage.toInt()}%',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // Animated Progress Bar
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Container(
                height: 1.h,
                decoration: BoxDecoration(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.getMotivationGradient(isLight: true),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 1.h),

          // Goal Information
          Text(
            'Goal: ₹${_formatCurrency(widget.monthlyGoal)}',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),

          SizedBox(height: 2.h),

          // Motivational Message
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.successLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.successLight.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'emoji_events',
                  color: AppTheme.successLight,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    _getMotivationalMessage(),
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.successLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  String _getMotivationalMessage() {
    if (widget.progressPercentage >= 100) {
      return 'Congratulations! You\'ve exceeded your monthly goal! 🎉';
    } else if (widget.progressPercentage >= 75) {
      return 'Amazing progress! You\'re almost there! 💪';
    } else if (widget.progressPercentage >= 50) {
      return 'Great work! You\'re halfway to your goal! 🚀';
    } else if (widget.progressPercentage >= 25) {
      return 'Good start! Keep up the momentum! ⭐';
    } else {
      return 'Every donation counts! Let\'s reach that goal! 🎯';
    }
  }
}
