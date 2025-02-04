import 'package:flutter/material.dart';
import '../models/persistence/my_profile.dart';

class UserProfileProvider extends InheritedWidget {
  final MyProfile userProfile;
  final ValueChanged<MyProfile> onProfileUpdated;

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
