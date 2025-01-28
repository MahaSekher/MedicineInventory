import 'package:flutter/material.dart';
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
        title: 'User Input App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
