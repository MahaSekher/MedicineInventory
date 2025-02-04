import 'package:flutter/material.dart';
import '../models/persistence/my_profile.dart';
import '../services/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MyProfile _myProfile = MyProfile(email: '', name: '', phone: '', address: '', emergencyContact: '', dob: '', gender: '', height: 0.0, weight: 0.0, image: '');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _emailError;
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);

    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email != null) {
      _loadProfile(email);
    } else {
      // Set error message if email is null
      setState(() {
        _emailError = 'Email not found. Please log in again.';
      });
    }
  }

  Future<void> _loadProfile(String email) async {
    final profile = await DatabaseHelper.instance.getProfile(email);

    if (profile != null) {
      setState(() {
        _myProfile = profile;

        _nameController.text = profile.name;
        _emailController.text = profile.email;
        _phoneController.text = profile.phone ?? '';
        _addressController.text = profile.address ?? '';
        _emergencyContactController.text = profile.emergencyContact ?? '';
        _dobController.text = profile.dob ?? '';
        _genderController.text = profile.gender ?? '';
        _heightController.text = profile.height?.toString() ?? '';
        _weightController.text = profile.weight?.toString() ?? '';
      });
    } else {
      setState(() {
        _myProfile = MyProfile(email: email, name: '', image: '');
        _emailController.text = email; // Populate email field with logged-in email
      });
    }
  }

  Future<void> _saveProfile() async {
    final updatedProfile = _myProfile.copyWith(
      email: _emailController.text,
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      emergencyContact: _emergencyContactController.text,
      dob: _dobController.text,
      gender: _genderController.text,
      height: double.tryParse(_heightController.text) ?? 0.0,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      image: _myProfile.image, // Keep the image field as is
    );

    print('Saving profile: ${updatedProfile.toMap()}');

    int result = await DatabaseHelper.instance.updateProfile(updatedProfile);
    print('Update result: $result');

    if (result == 0) {
      // If update failed, try inserting the profile
      result = await DatabaseHelper.instance.insertProfile(updatedProfile);
      print('Insert result: $result');
    }

    setState(() {
      _myProfile = updatedProfile;
    });

    _scaffoldMessengerState?.showSnackBar(SnackBar(content: Text('Profile saved successfully')));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_emailError != null) {
        _scaffoldMessengerState?.showSnackBar(SnackBar(content: Text(_emailError!)));
        Navigator.pop(context); // Go back to the previous screen
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProfile,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              enabled: false, // Email should not be editable
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _emergencyContactController,
              decoration: InputDecoration(labelText: 'Emergency Contact'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
