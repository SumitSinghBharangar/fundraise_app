import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionsWidget extends StatelessWidget {
  final VoidCallback onLeaderboardTap;
  final VoidCallback onAnnouncementsTap;

  const QuickActionsWidget({
    Key? key,
    required this.onLeaderboardTap,
    required this.onAnnouncementsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              // Leaderboard Action
              Expanded(
                child: _buildActionCard(
                  title: 'Leaderboard',
                  subtitle: 'Check your ranking',
                  iconName: 'leaderboard',
                  color: AppTheme.lightTheme.primaryColor,
                  onTap: onLeaderboardTap,
                ),
              ),
              SizedBox(width: 3.w),

              // Announcements Action
              Expanded(
                child: _buildActionCard(
                  title: 'Announcements',
                  subtitle: 'Latest updates',
                  iconName: 'campaign',
                  color: AppTheme.secondaryLight,
                  onTap: onAnnouncementsTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required String iconName,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
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
            // Icon
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: color,
                size: 6.w,
              ),
            ),

            SizedBox(height: 2.h),

            // Title
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 0.5.h),

            // Subtitle
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 2.h),

            // Arrow Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconWidget(
                  iconName: 'arrow_forward',
                  color: color,
                  size: 4.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
