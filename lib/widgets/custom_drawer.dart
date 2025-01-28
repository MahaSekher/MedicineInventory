import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../screens/profile_screen.dart';
import '../screens/vital_signs_screen.dart';
import '../widgets/user_profile_provider.dart';
import '../models/user_profile.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late UserProfile _userProfile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = UserProfileProvider.of(context);
    _userProfile = provider?.userProfile ?? UserProfile(name: 'Username', email: 'user@example.com');
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _userProfile.image = File(pickedFile.path);
        _updateProfile();
      });
    }
  }

  void _updateProfile() {
    UserProfileProvider.of(context)?.onProfileUpdated(_userProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_userProfile.name),
            accountEmail: Text(_userProfile.email),
            currentAccountPicture: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 38.0,
                  backgroundImage: _userProfile.image == null
                      ? AssetImage('assets/user_logo.png')
                      : FileImage(_userProfile.image!) as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Patient Records'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Appointments'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Prescriptions'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Billing'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    onProfileUpdated: (userProfile) {
                      setState(() {
                        _userProfile = userProfile;
                      });
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Vital Signs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VitalSignsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
