# FundRaise Portal 🚀

A Flutter mobile application designed to simulate a fundraising intern portal with clean UI, smooth animations, and comprehensive features for tracking donations, rewards, and leaderboards.

# 📱 Features

Authentication
Login/Sign-Up Pages - Clean UI with form validation
Social Login Integration - Google, Facebook, Apple sign-in options
Demo Credentials for testing:
admin@fundraise.com : admin123
intern@fundraise.com : intern123
manager@fundraise.com : manager123

Dashboard
Intern Profile - Name, photo, and personal details
Referral Code - Unique code generation (e.g., yourname2025)
Donation Tracking - Total donations raised with visual progress
Quick Actions - Easy access to key features
Real-time Stats - Dynamic counters and progress indicators

Leaderboard
Top Performers - Ranked list of fundraisers
Achievement Badges - Visual recognition system
Performance Metrics - Detailed statistics and comparisons
Interactive Rankings - Tap to view detailed profiles

Announcements
News Feed - Latest updates and notifications
Priority Alerts - Important announcements highlighted
Rich Content - Images, links, and formatted text support
Read Status - Track viewed announcements

Rewards System
Achievement Unlocks - Milestone-based rewards
Progress Tracking - Visual progress bars
Reward Categories - Different types of achievements
Gamification - Points, levels, and badges

# 🛠️ Technical Stack

Framework: Flutter 3.x
Language: Dart
State Management: Provider/Bloc pattern
UI Components: Custom widgets with Material Design
Animations: Flutter's built-in animation framework
Data Storage: Local JSON/Mock data (no backend required)

# 📦 Dependencies

dependencies:
flutter:
sdk: flutter
google_fonts: ^6.1.0
sizer: ^2.0.15
provider: ^6.1.1
shared_preferences: ^2.2.2
path_provider: ^2.1.1
image_picker: ^1.0.4
flutter_svg: ^2.0.9
animations: ^2.0.11

# 🚀 Getting Started

Prerequisites
Flutter SDK (3.0 or higher)
Dart SDK
Android Studio / VS Code
iOS Simulator / Android Emulator

Installation
Clone the repository

git clone https://github.com/SumitSinghBharangar/fundraise_app.git
cd fundraise-portal
Install dependencies

flutter pub get
For iOS (if developing on macOS)

cd ios
pod install
cd ..
Run the application

flutter run
Troubleshooting
If you encounter plugin issues:

flutter clean
flutter pub get
cd ios && pod install && cd .. # For iOS
flutter run

# 📁 Project Structure

lib/
├── main.dart # App entry point
├── screens/
│ ├── auth/
│ │ ├── login_screen.dart
│ │ └── signup_screen.dart
│ ├── dashboard/
│ │ └── dashboard_screen.dart
│ ├── leaderboard/
│ │ └── leaderboard_screen.dart
│ ├── announcements/
│ │ └── announcements_screen.dart
│ └── rewards/
│ └── rewards_screen.dart
├── widgets/
│ └── common/ # Reusable UI components
├── models/
│ └── data_models.dart # Data structures
├── services/
│ └── mock_data.dart # Dummy data service
└── utils/
├── constants.dart # App constants
└── themes.dart # App theming

# 🎨 UI/UX Features

Responsive Design - Adapts to different screen sizes
Smooth Animations - Page transitions and micro-interactions
Material Design - Following Google's design principles
Custom Fonts - Google Fonts integration
Dark/Light Theme - Theme switching capability
Haptic Feedback - Enhanced user interaction

# 📊 Mock Data

The app uses dummy data for demonstration:

5 Mock Users in leaderboard with donation amounts
Sample Announcements with different priority levels
Achievement System with unlockable rewards
Referral Codes auto-generated for each user

# 🔧 Customization

Theming
Modify lib/utils/themes.dart to customize:

Primary and accent colors
Typography styles
Component themes

# Mock Data

Update lib/services/mock_data.dart to change:

User profiles
Donation amounts
Announcements content
Reward structures

# 📱 Supported Platforms

✅ Android (API 21+)
✅ iOS (iOS 11.0+)
✅ Responsive design for tablets

# 🤝 Contributing

Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request
📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

# 📞 Support

For support and questions:

Create an issue in this repository
Email: bharangarsinghsumit@gmail.com
Phone: +91 9917709350

# 🙏 Acknowledgments

Flutter team for the amazing framework
Material Design for UI guidelines
Google Fonts for typography options
Made with ❤️ using Flutter

# Screenshots

![alt text](<WhatsApp Image 2025-08-01 at 23.54.06_e6673709.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.04_e93ad8dc.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.53.59_31757d82.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.17_a1a56035.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.16_e0f14eeb.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.15_fc7ec481.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.15_7c7cbaef.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.13_4f9178f6.jpg>)

![alt text](<WhatsApp Image 2025-08-01 at 23.54.09_501d6fda.jpg>)
