import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/donation_stats_widget.dart';
import './widgets/greeting_header_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/referral_code_widget.dart';
import './widgets/rewards_section_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _isRefreshing = false;

  // Mock Data
  final Map<String, dynamic> userData = {
    "name": "Priya Sharma",
    "profileImage":
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
    "referralCode": "PRIYA2024",
    "totalDonations": 125000.0,
    "monthlyGoal": 150000.0,
    "progressPercentage": 83.3,
  };

  final List<Map<String, dynamic>> rewardsData = [
    {
      "id": 1,
      "title": "First Milestone",
      "description": "Raised your first ₹10,000",
      "icon": "star",
      "isUnlocked": true,
      "progress": 10000,
      "target": 10000,
    },
    {
      "id": 2,
      "title": "Team Player",
      "description": "Collaborated with 5 team members",
      "icon": "group",
      "isUnlocked": true,
      "progress": 5,
      "target": 5,
    },
    {
      "id": 3,
      "title": "Super Fundraiser",
      "description": "Raise ₹1,00,000 in donations",
      "icon": "emoji_events",
      "isUnlocked": true,
      "progress": 100000,
      "target": 100000,
    },
    {
      "id": 4,
      "title": "Monthly Champion",
      "description": "Reach monthly goal of ₹1,50,000",
      "icon": "military_tech",
      "isUnlocked": false,
      "progress": 125000,
      "target": 150000,
    },
    {
      "id": 5,
      "title": "Consistency King",
      "description": "Meet weekly targets for 4 weeks",
      "icon": "trending_up",
      "isUnlocked": false,
      "progress": 3,
      "target": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.primaryColor,
          child: CustomScrollView(
            slivers: [
              // Greeting Header
              SliverToBoxAdapter(
                child: GreetingHeaderWidget(
                  userName: userData["name"] as String,
                  profileImageUrl: userData["profileImage"] as String,
                  onNotificationTap: _navigateToAnnouncements,
                ),
              ),

              // Referral Code Card
              SliverToBoxAdapter(
                child: ReferralCodeWidget(
                  referralCode: userData["referralCode"] as String,
                  onShare: _shareReferralCode,
                ),
              ),

              // Donation Statistics
              SliverToBoxAdapter(
                child: DonationStatsWidget(
                  totalDonations: userData["totalDonations"] as double,
                  monthlyGoal: userData["monthlyGoal"] as double,
                  progressPercentage: userData["progressPercentage"] as double,
                ),
              ),

              // Rewards Section
              SliverToBoxAdapter(
                child: RewardsSectionWidget(
                  rewards: rewardsData,
                  onViewAllRewards: _navigateToRewards,
                ),
              ),

              // Quick Actions
              SliverToBoxAdapter(
                child: QuickActionsWidget(
                  onLeaderboardTap: _navigateToLeaderboard,
                  onAnnouncementsTap: _navigateToAnnouncements,
                ),
              ),

              // Bottom Spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareReferralCode,
        backgroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
        child: CustomIconWidget(
          iconName: 'share',
          color: Colors.white,
          size: 6.w,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
      selectedLabelStyle:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
      unselectedLabelStyle:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: _currentIndex == 0
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 5.w,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'leaderboard',
            color: _currentIndex == 1
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 5.w,
          ),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'card_giftcard',
            color: _currentIndex == 2
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 5.w,
          ),
          label: 'Rewards',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'campaign',
            color: _currentIndex == 3
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 5.w,
          ),
          label: 'Announcements',
        ),
      ],
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Update mock data (simulate fresh data)
    setState(() {
      userData["totalDonations"] =
          (userData["totalDonations"] as double) + 5000;
      userData["progressPercentage"] = ((userData["totalDonations"] as double) /
              (userData["monthlyGoal"] as double)) *
          100;
      _isRefreshing = false;
    });

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Dashboard updated successfully!',
          style: AppTheme.lightTheme.snackBarTheme.contentTextStyle,
        ),
        backgroundColor: AppTheme.lightTheme.snackBarTheme.backgroundColor,
        behavior: AppTheme.lightTheme.snackBarTheme.behavior,
        shape: AppTheme.lightTheme.snackBarTheme.shape,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Dashboard
        break;
      case 1:
        _navigateToLeaderboard();
        break;
      case 2:
        _navigateToRewards();
        break;
      case 3:
        _navigateToAnnouncements();
        break;
    }
  }

  void _navigateToLeaderboard() {
    Navigator.pushNamed(context, '/leaderboard-screen');
  }

  void _navigateToAnnouncements() {
    Navigator.pushNamed(context, '/announcements-screen');
  }

  void _navigateToRewards() {
    Navigator.pushNamed(context, '/rewards-screen');
  }

  void _shareReferralCode() {
    final String shareText =
        'Join me in making a difference! Use my referral code: ${userData["referralCode"]} to get started with fundraising. Together, we can achieve great things! 🌟';

    // Show share dialog (mock implementation)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Share Referral Code',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                shareText,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                      'WhatsApp', 'message', AppTheme.successLight),
                  _buildShareOption('SMS', 'sms', AppTheme.secondaryLight),
                  _buildShareOption('Email', 'email', AppTheme.warningLight),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShareOption(String label, String iconName, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Shared via $label!'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
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
          SizedBox(height: 1.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
