import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RewardCardWidget extends StatelessWidget {
  final Map<String, dynamic> reward;
  final VoidCallback? onTap;

  const RewardCardWidget({
    Key? key,
    required this.reward,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isUnlocked = reward['status'] == 'unlocked';
    final bool isAvailable = reward['status'] == 'available';
    final bool isLocked = reward['status'] == 'locked';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75.w,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: isLocked
              ? AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUnlocked
                ? AppTheme.lightTheme.colorScheme.primary
                : isAvailable
                    ? AppTheme.lightTheme.colorScheme.tertiary
                    : AppTheme.lightTheme.colorScheme.outline,
            width: isUnlocked || isAvailable ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: isLocked
                          ? AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3)
                          : AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: reward['icon'] as String,
                        color: isLocked
                            ? AppTheme.lightTheme.colorScheme.outline
                            : AppTheme.lightTheme.colorScheme.primary,
                        size: 6.w,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isUnlocked)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 3.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Claimed',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (isLocked)
                    CustomIconWidget(
                      iconName: 'lock',
                      color: AppTheme.lightTheme.colorScheme.outline,
                      size: 5.w,
                    ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                reward['title'] as String,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: isLocked
                      ? AppTheme.lightTheme.colorScheme.outline
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 1.h),
              Text(
                reward['description'] as String,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: isLocked
                      ? AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.7)
                      : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'stars',
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    '${reward['points']} points',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (reward['progress'] != null && isLocked) ...[
                SizedBox(height: 1.h),
                LinearProgressIndicator(
                  value: (reward['progress'] as double) / 100,
                  backgroundColor: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${reward['progress']}% complete',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (isAvailable) ...[
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle claim action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Claim Reward',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
