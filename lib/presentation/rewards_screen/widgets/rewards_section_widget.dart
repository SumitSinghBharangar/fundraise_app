import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './reward_card_widget.dart';
import './reward_detail_modal.dart';

class RewardsSectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> rewards;
  final String emptyMessage;

  const RewardsSectionWidget({
    Key? key,
    required this.title,
    required this.rewards,
    required this.emptyMessage,
  }) : super(key: key);

  void _showRewardDetail(BuildContext context, Map<String, dynamic> reward) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RewardDetailModal(reward: reward),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${rewards.length}',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        rewards.isEmpty
            ? Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    CustomIconWidget(
                      iconName: 'card_giftcard',
                      color: AppTheme.lightTheme.colorScheme.outline,
                      size: 12.w,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      emptyMessage,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: 35.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return RewardCardWidget(
                      reward: reward,
                      onTap: () => _showRewardDetail(context, reward),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
