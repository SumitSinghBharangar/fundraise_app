import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/leaderboard_item.dart';
import './widgets/motivational_message.dart';
import './widgets/ranking_period_selector.dart';
import './widgets/skeleton_loader.dart';
import './widgets/user_position_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  String _selectedPeriod = 'This Week';
  bool _isLoading = false;
  bool _isRefreshing = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Mock data for leaderboard
  final Map<String, List<Map<String, dynamic>>> _leaderboardData = {
    'This Week': [
      {
        'rank': 1,
        'name': 'Priya Sharma',
        'amount': 125000.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Top Performer', 'Weekly Champion'],
      },
      {
        'rank': 2,
        'name': 'Arjun Patel',
        'amount': 118500.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Consistent Performer'],
      },
      {
        'rank': 3,
        'name': 'Sneha Reddy',
        'amount': 112300.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Rising Star'],
      },
      {
        'rank': 4,
        'name': 'Rohit Kumar',
        'amount': 98750.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': [],
      },
      {
        'rank': 5,
        'name': 'Kavya Singh',
        'amount': 87200.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Team Player'],
      },
    ],
    'This Month': [
      {
        'rank': 1,
        'name': 'Arjun Patel',
        'amount': 485000.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Monthly Champion', 'Consistency Award'],
      },
      {
        'rank': 2,
        'name': 'Priya Sharma',
        'amount': 467500.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Top Performer'],
      },
      {
        'rank': 3,
        'name': 'Rajesh Gupta',
        'amount': 423800.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Veteran Performer'],
      },
      {
        'rank': 4,
        'name': 'Sneha Reddy',
        'amount': 398200.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Rising Star'],
      },
      {
        'rank': 5,
        'name': 'Vikram Joshi',
        'amount': 356700.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': [],
      },
    ],
    'All Time': [
      {
        'rank': 1,
        'name': 'Rajesh Gupta',
        'amount': 2150000.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Legend', 'All-Time Champion', 'Mentor'],
      },
      {
        'rank': 2,
        'name': 'Arjun Patel',
        'amount': 1875000.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Consistency Master', 'Top Performer'],
      },
      {
        'rank': 3,
        'name': 'Meera Nair',
        'amount': 1654000.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Pioneer', 'Excellence Award'],
      },
      {
        'rank': 4,
        'name': 'Priya Sharma',
        'amount': 1432500.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Rising Champion'],
      },
      {
        'rank': 5,
        'name': 'Karan Malhotra',
        'amount': 1298700.0,
        'imageUrl':
            'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
        'achievements': ['Dedicated Performer'],
      },
    ],
  };

  // Current user data
  final Map<String, dynamic> _currentUser = {
    'rank': 7,
    'name': 'You (Rahul Verma)',
    'amount': 75500.0,
    'imageUrl':
        'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() => _isLoading = false);
    _animationController.forward();
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);
    HapticFeedback.lightImpact();

    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() => _isRefreshing = false);

    // Trigger haptic feedback for successful refresh
    HapticFeedback.selectionClick();
  }

  void _onPeriodChanged(String period) {
    if (period != _selectedPeriod) {
      setState(() {
        _selectedPeriod = period;
        _isLoading = true;
      });

      HapticFeedback.selectionClick();
      _animationController.reset();

      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() => _isLoading = false);
        _animationController.forward();
      });
    }
  }

  double _getMaxAmount() {
    final currentData = _leaderboardData[_selectedPeriod] ?? [];
    if (currentData.isEmpty) return 0.0;
    return (currentData.first['amount'] as double);
  }

  double _getNextMilestone() {
    final userAmount = _currentUser['amount'] as double;
    final milestones = [
      50000.0,
      100000.0,
      150000.0,
      200000.0,
      300000.0,
      500000.0
    ];

    for (final milestone in milestones) {
      if (userAmount < milestone) {
        return milestone;
      }
    }
    return userAmount + 100000.0; // Default next milestone
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 12.h,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Leaderboard',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      actions: [
        IconButton(
          onPressed: _refreshData,
          icon: _isRefreshing
              ? SizedBox(
                  width: 5.w,
                  height: 5.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                )
              : CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 5.w,
                ),
        ),
        SizedBox(width: 2.w),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const SliverToBoxAdapter(
        child: SkeletonLoader(),
      );
    }

    final currentData = _leaderboardData[_selectedPeriod] ?? [];
    final maxAmount = _getMaxAmount();

    return SliverList(
      delegate: SliverChildListDelegate([
        RankingPeriodSelector(
          selectedPeriod: _selectedPeriod,
          onPeriodChanged: _onPeriodChanged,
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: UserPositionCard(userData: _currentUser),
        ),
        SizedBox(height: 1.h),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Top Performers',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        ...currentData.asMap().entries.map((entry) {
          final index = entry.key;
          final userData = entry.value;
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  index * 0.1,
                  (index * 0.1) + 0.3,
                  curve: Curves.easeOut,
                ),
              )),
              child: LeaderboardItem(
                userData: userData,
                index: index,
                maxAmount: maxAmount,
              ),
            ),
          );
        }).toList(),
        FadeTransition(
          opacity: _fadeAnimation,
          child: MotivationalMessage(
            userRank: _currentUser['rank'] as int,
            userAmount: _currentUser['amount'] as double,
            nextMilestone: _getNextMilestone(),
          ),
        ),
        SizedBox(height: 10.h), // Bottom padding for navigation
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildAppBar(),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
