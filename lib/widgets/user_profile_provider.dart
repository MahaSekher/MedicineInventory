import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class UserProfileProvider extends InheritedWidget {
  final UserProfile userProfile;
  final ValueChanged<UserProfile> onProfileUpdated;

  UserProfileProvider({
    Key? key,
    required Widget child,
    required this.userProfile,
    required this.onProfileUpdated,
  }) : super(key: key, child: child);

  static UserProfileProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProfileProvider>();
  }

  @override
  bool updateShouldNotify(UserProfileProvider oldWidget) {
    return userProfile != oldWidget.userProfile;
  }
}
