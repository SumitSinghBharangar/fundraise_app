import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyAnnouncementsWidget extends StatelessWidget {
  final VoidCallback? onRefresh;
  final String message;
  final String? subtitle;

  const EmptyAnnouncementsWidget({
    Key? key,
    this.onRefresh,
    this.message = 'No announcements found',
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'notifications_none',
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.6),
                  size: 20.w,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              message,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 1.h),
              Text(
                subtitle!,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRefresh != null) ...[
              SizedBox(height: 4.h),
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: Colors.white,
                  size: 18,
                ),
                label: Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
