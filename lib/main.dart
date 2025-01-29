import 'package:flutter/material.dart';
import 'package:user_input_app/screens/login_screen.dart';
import 'package:user_input_app/themes/app_theme.dart';
import 'models/user_profile.dart';
import 'widgets/user_profile_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserProfile _userProfile = UserProfile(name: 'Username', email: 'user@example.com');

  @override
  Widget build(BuildContext context) {
    return UserProfileProvider(
      userProfile: _userProfile,
      onProfileUpdated: (updatedProfile) {
        _userProfile.name = updatedProfile.name;
        _userProfile.email = updatedProfile.email;
        _userProfile.image = updatedProfile.image;
      },
      child: MaterialApp(
        title: 'EMR App',
        theme: AppTheme.lightTheme,// Optionally apply a dark theme
        home: HomeScreen(),
      ),
    );
  }
}
