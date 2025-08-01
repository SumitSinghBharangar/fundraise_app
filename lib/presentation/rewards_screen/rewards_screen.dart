import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/rewards_section_widget.dart';
import './widgets/tier_progress_widget.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Digital Badges',
    'Physical Rewards',
    'Experiences',
    'Recognition'
  ];

  final Map<String, dynamic> tierData = {
    'currentPoints': 2450,
    'nextTierPoints': 5000,
    'currentTier': 'Silver Champion',
    'nextTier': 'Gold Elite',
  };

  final List<Map<String, dynamic>> allRewards = [
    {
      'id': 1,
      'title': 'First Donation Badge',
      'description': 'Celebrate your first successful donation collection',
      'fullDescription':
          'This digital badge recognizes your first milestone in fundraising. It represents the beginning of your journey as a fundraising champion and will be displayed on your profile for all to see.',
      'icon': 'military_tech',
      'points': 100,
      'status': 'unlocked',
      'category': 'Digital Badges',
      'unlockCriteria': [
        'Collect your first donation',
        'Complete profile setup'
      ],
      'terms':
          'This badge is permanent and cannot be transferred. It will remain on your profile indefinitely.',
    },
    {
      'id': 2,
      'title': 'Top Performer Certificate',
      'description':
          'Official recognition for outstanding fundraising performance',
      'fullDescription':
          'A professionally designed certificate acknowledging your exceptional fundraising achievements. This certificate can be used for academic credit, resume building, and professional recognition.',
      'icon': 'workspace_premium',
      'points': 500,
      'status': 'available',
      'category': 'Recognition',
      'unlockCriteria': [
        'Raise ₹50,000 in total donations',
        'Maintain top 10 position for 30 days'
      ],
      'terms':
          'Certificate will be issued within 7 business days. Physical copy can be requested for additional shipping charges.',
    },
    {
      'id': 3,
      'title': 'Fundraising Hero T-Shirt',
      'description': 'Exclusive branded merchandise for dedicated fundraisers',
      'fullDescription':
          'High-quality cotton t-shirt with exclusive "Fundraising Hero" design. Available in multiple sizes and colors. Show your commitment to the cause with pride.',
      'icon': 'checkroom',
      'points': 1000,
      'status': 'locked',
      'progress': 65.0,
      'category': 'Physical Rewards',
      'unlockCriteria': [
        'Reach 1000 points',
        'Complete 20 successful donations',
        'Refer 5 new fundraisers'
      ],
      'terms':
          'Shipping included within India. International shipping charges apply. Size exchange available within 30 days.',
    },
    {
      'id': 4,
      'title': 'Leadership Workshop Access',
      'description': 'Exclusive access to professional development workshops',
      'fullDescription':
          'Join our exclusive leadership development program featuring workshops on communication, team management, and professional growth. Led by industry experts and successful entrepreneurs.',
      'icon': 'school',
      'points': 1500,
      'status': 'locked',
      'progress': 45.0,
      'category': 'Experiences',
      'unlockCriteria': [
        'Earn 1500 points',
        'Complete advanced fundraising course',
        'Demonstrate leadership in team activities'
      ],
      'terms':
          'Workshop dates are subject to availability. Minimum 10 participants required. Certificate of completion provided.',
    },
    {
      'id': 5,
      'title': 'Monthly Champion Badge',
      'description': 'Recognition for being the top performer of the month',
      'fullDescription':
          'This prestigious badge is awarded to the highest performing fundraiser each month. It comes with special privileges and recognition in our monthly newsletter.',
      'icon': 'emoji_events',
      'points': 2000,
      'status': 'available',
      'category': 'Digital Badges',
      'unlockCriteria': [
        'Be the top fundraiser for any month',
        'Maintain consistent performance'
      ],
      'terms':
          'Badge is awarded monthly. Previous winners are eligible for subsequent months. Special privileges valid for 30 days.',
    },
    {
      'id': 6,
      'title': 'Networking Event Invitation',
      'description':
          'VIP access to exclusive networking events with industry leaders',
      'fullDescription':
          'Get invited to our quarterly networking events where you can meet successful entrepreneurs, industry leaders, and fellow top performers. Great opportunity for career growth and mentorship.',
      'icon': 'groups',
      'points': 3000,
      'status': 'locked',
      'progress': 25.0,
      'category': 'Experiences',
      'unlockCriteria': [
        'Accumulate 3000 points',
        'Complete professional profile',
        'Attend at least 2 training sessions'
      ],
      'terms':
          'Event locations vary. Transportation not included. Professional attire required. RSVP mandatory.',
    },
    {
      'id': 7,
      'title': 'Mentor Recognition',
      'description':
          'Special recognition for helping and mentoring new fundraisers',
      'fullDescription':
          'This award recognizes your contribution in mentoring and supporting new team members. Your guidance helps build a stronger fundraising community.',
      'icon': 'supervisor_account',
      'points': 800,
      'status': 'locked',
      'progress': 80.0,
      'category': 'Recognition',
      'unlockCriteria': [
        'Mentor at least 3 new fundraisers',
        'Receive positive feedback from mentees',
        'Complete mentor training program'
      ],
      'terms':
          'Recognition includes profile highlight and special mentor badge. Mentoring activities must be documented and verified.',
    },
    {
      'id': 8,
      'title': 'Fundraising Toolkit',
      'description': 'Professional fundraising materials and resources package',
      'fullDescription':
          'Comprehensive toolkit including presentation templates, pitch decks, communication scripts, and professional fundraising guides to enhance your effectiveness.',
      'icon': 'work',
      'points': 1200,
      'status': 'locked',
      'progress': 35.0,
      'category': 'Physical Rewards',
      'unlockCriteria': [
        'Reach intermediate fundraiser level',
        'Complete skills assessment',
        'Demonstrate consistent performance'
      ],
      'terms':
          'Digital delivery via email. Physical materials available for additional cost. Updates included for 6 months.',
    },
  ];

  List<Map<String, dynamic>> get filteredRewards {
    if (selectedCategory == 'All') {
      return allRewards;
    }
    return allRewards
        .where((reward) => reward['category'] == selectedCategory)
        .toList();
  }

  List<Map<String, dynamic>> get unlockedRewards {
    return filteredRewards
        .where((reward) => reward['status'] == 'unlocked')
        .toList();
  }

  List<Map<String, dynamic>> get availableRewards {
    return filteredRewards
        .where((reward) => reward['status'] == 'available')
        .toList();
  }

  List<Map<String, dynamic>> get lockedRewards {
    return filteredRewards
        .where((reward) => reward['status'] == 'locked')
        .toList();
  }

  Future<void> _onRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh reward data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Rewards & Achievements',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 6.w,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: TierProgressWidget(tierData: tierData),
              ),
              SizedBox(height: 3.h),
              FilterChipsWidget(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              SizedBox(height: 3.h),
              RewardsSectionWidget(
                title: 'Unlocked Achievements',
                rewards: unlockedRewards,
                emptyMessage:
                    'No unlocked achievements yet.\nStart fundraising to earn your first rewards!',
              ),
              SizedBox(height: 4.h),
              RewardsSectionWidget(
                title: 'Available Rewards',
                rewards: availableRewards,
                emptyMessage:
                    'No rewards available to claim right now.\nKeep fundraising to unlock more rewards!',
              ),
              SizedBox(height: 4.h),
              RewardsSectionWidget(
                title: 'Locked Rewards',
                rewards: lockedRewards,
                emptyMessage:
                    'All rewards in this category are unlocked!\nCheck other categories for more challenges.',
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
