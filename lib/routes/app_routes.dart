import 'package:flutter/material.dart';
import '../presentation/dashboard_screen/dashboard_screen.dart';
import '../presentation/leaderboard_screen/leaderboard_screen.dart';
import '../presentation/rewards_screen/rewards_screen.dart';
import '../presentation/announcements_screen/announcements_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';

class AppRoutes {
  
  static const String initial = '/';
  static const String dashboard = '/dashboard-screen';
  static const String leaderboard = '/leaderboard-screen';
  static const String rewards = '/rewards-screen';
  static const String announcements = '/announcements-screen';
  static const String login = '/login-screen';
  static const String signUp = '/sign-up-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
    leaderboard: (context) => const LeaderboardScreen(),
    rewards: (context) => const RewardsScreen(),
    announcements: (context) => const AnnouncementsScreen(),
    login: (context) => const LoginScreen(),
    signUp: (context) => const SignUpScreen(),
    
  };
}