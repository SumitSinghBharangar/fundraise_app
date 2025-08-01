import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MotivationalMessage extends StatelessWidget {
  final int userRank;
  final double userAmount;
  final double nextMilestone;

  const MotivationalMessage({
    Key? key,
    required this.userRank,
    required this.userAmount,
    required this.nextMilestone,
  }) : super(key: key);

  String _getMotivationalText() {
    if (userRank <= 3) {
      return "Amazing work! You're in the top 3! Keep up the excellent performance!";
    } else if (userRank <= 5) {
      return "You're so close to the top 3! Just a little more effort to climb higher!";
    } else if (userRank <= 10) {
      return "Great progress! You're in the top 10. Push forward to reach the top 5!";
    } else {
      return "Every donation counts! Keep going and watch your ranking improve!";
    }
  }

  String _getTipText() {
    final tips = [
      "💡 Tip: Share your referral code with friends and family",
      "🎯 Tip: Set daily donation goals to stay motivated",
      "📱 Tip: Use social media to spread awareness",
      "🤝 Tip: Partner with local businesses for fundraising",
      "⏰ Tip: Follow up with potential donors regularly",
    ];
    return tips[DateTime.now().day % tips.length];
  }

  @override
  Widget build(BuildContext context) {
    final amountNeeded = nextMilestone - userAmount;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'emoji_events',
                color: AppTheme.lightTheme.colorScheme.tertiary,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  'Keep Going!',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Text(
            _getMotivationalText(),
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          if (amountNeeded > 0) ...[
            SizedBox(height: 1.5.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'trending_up',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 4.w,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Next milestone: ₹${amountNeeded.toStringAsFixed(0)} more to reach ₹${nextMilestone.toStringAsFixed(0)}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 1.5.h),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.tertiary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  _getTipText(),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.8),
                    fontSize: 11.sp,
                    fontStyle: FontStyle.italic,
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
