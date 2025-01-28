import 'dart:io';

class UserProfile {
  String name;
  String email;
  File? image;

  UserProfile({
    required this.name,
    required this.email,
    this.image,
  });
}
