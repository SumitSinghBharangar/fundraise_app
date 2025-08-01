import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AnnouncementCardWidget extends StatelessWidget {
  final Map<String, dynamic> announcement;
  final VoidCallback onTap;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onBookmark;

  const AnnouncementCardWidget({
    Key? key,
    required this.announcement,
    required this.onTap,
    this.onMarkAsRead,
    this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isUnread = announcement['isUnread'] as bool? ?? false;
    final bool isBookmarked = announcement['isBookmarked'] as bool? ?? false;
    final bool isPriority = announcement['isPriority'] as bool? ?? false;
    final String? imageUrl = announcement['imageUrl'] as String?;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showContextMenu(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: isPriority
              ? Border.all(
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  width: 2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color:
                  AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPriority)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'priority_high',
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Priority Announcement',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(top: 0.5.h, right: 2.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  announcement['date'] as String? ?? '',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (isBookmarked)
                                      CustomIconWidget(
                                        iconName: 'bookmark',
                                        color: AppTheme
                                            .lightTheme.colorScheme.tertiary,
                                        size: 16,
                                      ),
                                    SizedBox(width: 2.w),
                                    CustomIconWidget(
                                      iconName: 'more_vert',
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              announcement['title'] as String? ?? '',
                              style: isUnread
                                  ? AppTheme.lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )
                                  : AppTheme.lightTheme.textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              announcement['preview'] as String? ?? '',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (imageUrl != null && imageUrl.isNotEmpty) ...[
                        SizedBox(width: 3.w),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImageWidget(
                            imageUrl: imageUrl,
                            width: 20.w,
                            height: 15.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (announcement['category'] != null) ...[
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        announcement['category'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            _buildContextMenuItem(
              context,
              icon: 'share',
              title: 'Share',
              onTap: () {
                Navigator.pop(context);
                // Share functionality would be implemented here
              },
            ),
            _buildContextMenuItem(
              context,
              icon: announcement['isBookmarked'] == true
                  ? 'bookmark_remove'
                  : 'bookmark_add',
              title: announcement['isBookmarked'] == true
                  ? 'Remove Bookmark'
                  : 'Bookmark',
              onTap: () {
                Navigator.pop(context);
                onBookmark?.call();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: announcement['isUnread'] == true
                  ? 'mark_email_read'
                  : 'mark_email_unread',
              title: announcement['isUnread'] == true
                  ? 'Mark as Read'
                  : 'Mark as Unread',
              onTap: () {
                Navigator.pop(context);
                onMarkAsRead?.call();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.colorScheme.onSurface,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
