import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LeaderboardItem extends StatelessWidget {
  final Map<String, dynamic> userData;
  final int index;
  final double maxAmount;

  const LeaderboardItem({
    Key? key,
    required this.userData,
    required this.index,
    required this.maxAmount,
  }) : super(key: key);

  Widget _buildMedalIcon(int position) {
    if (position == 1) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: CustomIconWidget(
          iconName: 'emoji_events',
          color: Colors.white,
          size: 4.w,
        ),
      );
    } else if (position == 2) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC0C0C0), Color(0xFF808080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: CustomIconWidget(
          iconName: 'emoji_events',
          color: Colors.white,
          size: 4.w,
        ),
      );
    } else if (position == 3) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCD7F32), Color(0xFF8B4513)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: CustomIconWidget(
          iconName: 'emoji_events',
          color: Colors.white,
          size: 4.w,
        ),
      );
    } else {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Center(
          child: Text(
            '$position',
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rank = userData['rank'] as int;
    final name = userData['name'] as String;
    final amount = userData['amount'] as double;
    final imageUrl = userData['imageUrl'] as String;
    final achievements =
        (userData['achievements'] as List?)?.cast<String>() ?? [];

    final progressPercentage = maxAmount > 0 ? (amount / maxAmount) : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildMedalIcon(rank),
              SizedBox(width: 3.w),
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: rank <= 3
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                    width: rank <= 3 ? 2 : 1,
                  ),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl: imageUrl,
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (achievements.isNotEmpty) ...[
                          SizedBox(width: 2.w),
                          CustomIconWidget(
                            iconName: 'star',
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            size: 4.w,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '₹${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            height: 0.8.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressPercentage.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.lightTheme.colorScheme.primary,
                      AppTheme.lightTheme.colorScheme.secondary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
