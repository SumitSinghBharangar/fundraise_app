import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/announcement_card_widget.dart';
import './widgets/announcement_filter_widget.dart';
import './widgets/announcement_search_widget.dart';
import './widgets/empty_announcements_widget.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  String? _selectedCategory;
  DateTimeRange? _selectedDateRange;
  bool _isRefreshing = false;

  // Mock data for announcements
  final List<Map<String, dynamic>> _allAnnouncements = [
    {
      "id": 1,
      "title": "New Fundraising Campaign Launch",
      "preview":
          "We're excited to announce the launch of our new education fundraising campaign. This initiative aims to provide scholarships for underprivileged students across India.",
      "content":
          """We're thrilled to announce the launch of our new education fundraising campaign, 'Education for All'. This comprehensive initiative aims to provide scholarships and educational resources for underprivileged students across India. Our goal is to raise ₹50,00,000 over the next 6 months to support 500 students with their educational expenses including tuition fees, books, and learning materials. Key highlights: • Scholarship amounts ranging from ₹5,000 to ₹25,000 per student • Focus on students from rural and economically disadvantaged backgrounds • Partnership with leading educational institutions • Transparent fund allocation and progress tracking As fundraising interns, you play a crucial role in making this vision a reality. Your dedication and efforts directly impact the lives of these deserving students. For more information and campaign materials, please check the resources section in your dashboard.""",
      "date": "01/08/2025",
      "category": "Campaigns",
      "imageUrl":
          "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "isUnread": true,
      "isBookmarked": false,
      "isPriority": true,
      "author": "Campaign Team",
      "readTime": "3 min read"
    },
    {
      "id": 2,
      "title": "Monthly Performance Review Meeting",
      "preview":
          "Join us for the monthly performance review meeting scheduled for August 5th. We'll discuss achievements, challenges, and upcoming opportunities.",
      "content":
          """Dear Fundraising Interns, You are cordially invited to attend our monthly performance review meeting scheduled for August 5th, 2025, at 3:00 PM via video conference. Agenda: 1. Review of July performance metrics 2. Recognition of top performers 3. Discussion of challenges and solutions 4. Introduction of new fundraising strategies 5. Q&A session Please come prepared with: • Your monthly performance summary • Any challenges you've faced • Suggestions for improvement • Questions about new initiatives Meeting Link: [Video Conference Link] Meeting ID: 123-456-789 Password: FundRaise2025 Looking forward to seeing everyone there!""",
      "date": "31/07/2025",
      "category": "Meetings",
      "imageUrl":
          "https://images.unsplash.com/photo-1552664730-d307ca884978?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "isUnread": true,
      "isBookmarked": true,
      "isPriority": false,
      "author": "HR Team",
      "readTime": "2 min read"
    },
    {
      "id": 3,
      "title": "Updated Commission Structure",
      "preview":
          "We're pleased to announce updates to our commission structure effective August 1st. The new structure offers better incentives for high performers.",
      "content":
          """We're excited to announce significant updates to our commission structure, effective August 1st, 2025. These changes are designed to better reward your hard work and provide enhanced incentives for exceptional performance. New Commission Tiers: • Bronze Level (₹0 - ₹50,000): 5% commission • Silver Level (₹50,001 - ₹1,00,000): 7% commission • Gold Level (₹1,00,001 - ₹2,00,000): 10% commission • Platinum Level (₹2,00,001+): 12% commission + bonus rewards Additional Benefits: • Monthly performance bonuses for top 10 performers • Quarterly achievement awards • Annual recognition program • Career advancement opportunities The new structure also includes: • Faster payment processing (within 7 days) • Transparent tracking through your dashboard • Performance analytics and insights • Mentorship opportunities for high achievers For detailed information about the new commission structure, please refer to the updated handbook in your dashboard resources section.""",
      "date": "30/07/2025",
      "category": "Policy Updates",
      "imageUrl":
          "https://images.unsplash.com/photo-1554224155-6726b3ff858f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "isUnread": false,
      "isBookmarked": false,
      "isPriority": true,
      "author": "Management Team",
      "readTime": "4 min read"
    },
    {
      "id": 4,
      "title": "Training Workshop: Advanced Fundraising Techniques",
      "preview":
          "Enhance your fundraising skills with our upcoming workshop on advanced techniques. Learn from industry experts and boost your performance.",
      "content":
          """Join us for an exclusive training workshop on 'Advanced Fundraising Techniques' designed specifically for our fundraising interns. Workshop Details: Date: August 8th, 2025 Time: 10:00 AM - 4:00 PM Venue: Conference Hall, Main Office Trainer: Rajesh Kumar (Senior Fundraising Consultant) Topics Covered: • Psychology of donor engagement • Digital fundraising strategies • Building long-term donor relationships • Effective communication techniques • Handling objections and rejections • Using technology for better results What You'll Gain: • Practical skills to increase donation success rates • Networking opportunities with fellow interns • Certificate of completion • Resource materials and templates • One-on-one feedback session Registration: Please confirm your attendance by August 3rd through the dashboard or by replying to this announcement. Lunch and refreshments will be provided. This is a mandatory training for all active interns. Don't miss this opportunity to enhance your skills and boost your earning potential!""",
      "date": "29/07/2025",
      "category": "Training",
      "imageUrl":
          "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "isUnread": false,
      "isBookmarked": true,
      "isPriority": false,
      "author": "Training Department",
      "readTime": "3 min read"
    },
    {
      "id": 5,
      "title": "System Maintenance Notice",
      "preview":
          "Scheduled system maintenance on August 3rd from 2:00 AM to 4:00 AM. The portal will be temporarily unavailable during this time.",
      "content":
          """Important System Maintenance Notice We will be performing scheduled system maintenance to improve the performance and security of the FundRaise Portal. Maintenance Schedule: Date: August 3rd, 2025 Time: 2:00 AM - 4:00 AM IST Duration: Approximately 2 hours During this maintenance window: • The portal will be temporarily unavailable • Mobile app functionality will be limited • Data synchronization will be paused • Payment processing will be temporarily suspended What to Expect After Maintenance: • Improved system performance • Enhanced security features • Bug fixes and stability improvements • New dashboard features Preparation Steps: • Complete any pending submissions before 2:00 AM • Download any required reports in advance • Plan your fundraising activities accordingly We apologize for any inconvenience this may cause and appreciate your understanding. If you have any urgent issues during the maintenance window, please contact our emergency support line. Thank you for your patience as we work to improve your experience with the FundRaise Portal.""",
      "date": "28/07/2025",
      "category": "System Updates",
      "imageUrl": null,
      "isUnread": false,
      "isBookmarked": false,
      "isPriority": false,
      "author": "IT Team",
      "readTime": "2 min read"
    },
    {
      "id": 6,
      "title": "Congratulations to July Top Performers!",
      "preview":
          "Celebrating our outstanding performers for July 2025. See if you made it to the top 10 and learn about the upcoming rewards ceremony.",
      "content":
          """🎉 Congratulations to Our July 2025 Top Performers! 🎉 We're thrilled to recognize the exceptional achievements of our fundraising interns who went above and beyond in July. Top 10 Performers: 1. Priya Sharma - ₹3,45,000 raised 2. Arjun Patel - ₹3,12,000 raised 3. Sneha Reddy - ₹2,98,000 raised 4. Vikram Singh - ₹2,87,000 raised 5. Anita Gupta - ₹2,76,000 raised 6. Rohit Kumar - ₹2,65,000 raised 7. Meera Joshi - ₹2,54,000 raised 8. Karan Mehta - ₹2,43,000 raised 9. Divya Nair - ₹2,32,000 raised 10. Amit Verma - ₹2,21,000 raised Special Recognition: • Highest Single Donation: Priya Sharma (₹75,000) • Most Consistent Performer: Arjun Patel • Best Newcomer: Divya Nair • Team Player Award: Sneha Reddy Rewards Ceremony: Date: August 10th, 2025 Time: 6:00 PM Venue: Grand Ballroom, Hotel Meridian All top performers will receive: • Cash bonuses based on performance tier • Recognition certificates • Gift vouchers • Special mention in company newsletter Keep up the excellent work, and congratulations to all our dedicated fundraising interns!""",
      "date": "27/07/2025",
      "category": "Recognition",
      "imageUrl":
          "https://images.unsplash.com/photo-1552664730-d307ca884978?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "isUnread": false,
      "isBookmarked": false,
      "isPriority": false,
      "author": "Management Team",
      "readTime": "3 min read"
    }
  ];

  List<Map<String, dynamic>> _filteredAnnouncements = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeData() {
    _filteredAnnouncements = List.from(_allAnnouncements);
    _categories = _allAnnouncements
        .map((announcement) => announcement['category'] as String)
        .toSet()
        .toList();
  }

  void _filterAnnouncements() {
    setState(() {
      _filteredAnnouncements = _allAnnouncements.where((announcement) {
        // Search filter
        if (_searchQuery.isNotEmpty) {
          final title = (announcement['title'] as String).toLowerCase();
          final preview = (announcement['preview'] as String).toLowerCase();
          final content = (announcement['content'] as String).toLowerCase();
          final searchLower = _searchQuery.toLowerCase();

          if (!title.contains(searchLower) &&
              !preview.contains(searchLower) &&
              !content.contains(searchLower)) {
            return false;
          }
        }

        // Category filter
        if (_selectedCategory != null &&
            announcement['category'] != _selectedCategory) {
          return false;
        }

        // Date range filter
        if (_selectedDateRange != null) {
          final announcementDate = _parseDate(announcement['date'] as String);
          if (announcementDate.isBefore(_selectedDateRange!.start) ||
              announcementDate.isAfter(_selectedDateRange!.end)) {
            return false;
          }
        }

        return true;
      }).toList();

      // Sort by priority and date
      _filteredAnnouncements.sort((a, b) {
        // Priority announcements first
        final aPriority = a['isPriority'] as bool? ?? false;
        final bPriority = b['isPriority'] as bool? ?? false;

        if (aPriority && !bPriority) return -1;
        if (!aPriority && bPriority) return 1;

        // Then by unread status
        final aUnread = a['isUnread'] as bool? ?? false;
        final bUnread = b['isUnread'] as bool? ?? false;

        if (aUnread && !bUnread) return -1;
        if (!aUnread && bUnread) return 1;

        // Finally by date (newest first)
        final aDate = _parseDate(a['date'] as String);
        final bDate = _parseDate(b['date'] as String);
        return bDate.compareTo(aDate);
      });
    });
  }

  DateTime _parseDate(String dateString) {
    final parts = dateString.split('/');
    return DateTime(
      int.parse(parts[2]), // year
      int.parse(parts[1]), // month
      int.parse(parts[0]), // day
    );
  }

  Future<void> _refreshAnnouncements() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });

    // Show refresh feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Announcements refreshed'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _markAsRead(int announcementId) {
    setState(() {
      final index =
          _allAnnouncements.indexWhere((a) => a['id'] == announcementId);
      if (index != -1) {
        _allAnnouncements[index]['isUnread'] = false;
      }
    });
    _filterAnnouncements();
  }

  void _toggleBookmark(int announcementId) {
    setState(() {
      final index =
          _allAnnouncements.indexWhere((a) => a['id'] == announcementId);
      if (index != -1) {
        final currentStatus =
            _allAnnouncements[index]['isBookmarked'] as bool? ?? false;
        _allAnnouncements[index]['isBookmarked'] = !currentStatus;
      }
    });
    _filterAnnouncements();
  }

  void _showAnnouncementDetail(Map<String, dynamic> announcement) {
    // Mark as read when opened
    _markAsRead(announcement['id'] as int);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            _AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnnouncementFilterWidget(
        categories: _categories,
        selectedCategory: _selectedCategory,
        onCategoryChanged: (category) {
          setState(() {
            _selectedCategory = category;
          });
          _filterAnnouncements();
        },
        onDateRangeChanged: (dateRange) {
          setState(() {
            _selectedDateRange = dateRange;
          });
          _filterAnnouncements();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'campaign',
                  color: Colors.white,
                  size: 5.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Text('All Announcements'),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to notifications or show notification panel
                },
                icon: CustomIconWidget(
                  iconName: 'notifications',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          AnnouncementSearchWidget(
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _filterAnnouncements();
            },
            onFilterTap: _showFilterBottomSheet,
          ),
          if (_selectedCategory != null || _selectedDateRange != null)
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'filter_alt',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      _buildFilterText(),
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = null;
                        _selectedDateRange = null;
                      });
                      _filterAnnouncements();
                    },
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _isRefreshing
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  )
                : _filteredAnnouncements.isEmpty
                    ? EmptyAnnouncementsWidget(
                        onRefresh: _refreshAnnouncements,
                        message: _searchQuery.isNotEmpty ||
                                _selectedCategory != null ||
                                _selectedDateRange != null
                            ? 'No announcements match your filters'
                            : 'No announcements available',
                        subtitle: _searchQuery.isNotEmpty ||
                                _selectedCategory != null ||
                                _selectedDateRange != null
                            ? 'Try adjusting your search or filters'
                            : 'Pull down to refresh and check for new announcements',
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshAnnouncements,
                        color: AppTheme.lightTheme.colorScheme.primary,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _filteredAnnouncements.length,
                          itemBuilder: (context, index) {
                            final announcement = _filteredAnnouncements[index];
                            return AnnouncementCardWidget(
                              announcement: announcement,
                              onTap: () =>
                                  _showAnnouncementDetail(announcement),
                              onMarkAsRead: () =>
                                  _markAsRead(announcement['id'] as int),
                              onBookmark: () =>
                                  _toggleBookmark(announcement['id'] as int),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  String _buildFilterText() {
    List<String> filters = [];

    if (_selectedCategory != null) {
      filters.add('Category: $_selectedCategory');
    }

    if (_selectedDateRange != null) {
      filters.add(
          'Date: ${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}');
    }

    return filters.join(' • ');
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

class _AnnouncementDetailScreen extends StatelessWidget {
  final Map<String, dynamic> announcement;

  const _AnnouncementDetailScreen({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = announcement['imageUrl'] as String?;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Announcement'),
        actions: [
          IconButton(
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sharing announcement...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              // Bookmark functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(announcement['isBookmarked'] == true
                      ? 'Removed from bookmarks'
                      : 'Added to bookmarks'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: announcement['isBookmarked'] == true
                  ? 'bookmark'
                  : 'bookmark_border',
              color: announcement['isBookmarked'] == true
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              CustomImageWidget(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 50.w,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (announcement['isPriority'] == true)
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.5.h),
                      margin: EdgeInsets.only(bottom: 2.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.tertiary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'priority_high',
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Priority Announcement',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Text(
                    announcement['title'] as String? ?? '',
                    style: AppTheme.lightTheme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          announcement['category'] as String? ?? '',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        announcement['date'] as String? ?? '',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (announcement['readTime'] != null) ...[
                        SizedBox(width: 3.w),
                        CustomIconWidget(
                          iconName: 'schedule',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          announcement['readTime'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (announcement['author'] != null) ...[
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'person',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'By ${announcement['author']}',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 3.h),
                  Text(
                    announcement['content'] as String? ?? '',
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
