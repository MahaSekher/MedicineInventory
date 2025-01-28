import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/user_profile_provider.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  final ValueChanged<UserProfile> onProfileUpdated;

  ProfileScreen({required this.onProfileUpdated});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;
  final _formKey = GlobalKey<FormState>();

// Define variables for additional fields
  String _age = '';
  String _gender = 'M'; // Default value
  String _height = '';
  String _weight = '';
  String _bloodPressure = '';
  String _heartRate = '';
  String _temperature = '';
  String _respiratoryRate = '';
  DateTime? _dateOfBirth;
  String _contactNumber = '';
  String _address = '';
  String _emergencyContact = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = UserProfileProvider.of(context);
    _userProfile = provider?.userProfile ?? UserProfile(name: 'Username', email: 'user@example.com');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
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
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _userProfile.image == null
                      ? AssetImage('assets/user_logo.png')
                      : FileImage(_userProfile.image!) as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _userProfile.name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _userProfile.name = value;
                  _updateProfile();
                },
              ),
              TextFormField(
                initialValue: _userProfile.email,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  _userProfile.email = value;
                  _updateProfile();
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                onChanged: (value) => setState(() {
                  _contactNumber = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onChanged: (value) => setState(() {
                  _address = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Emergency Contact'),
                onChanged: (value) => setState(() {
                  _emergencyContact = value;
                }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      onChanged: (value) => setState(() {
                        _age = value;
                      }),
                    ),
                  ),
                  Text('or'),
                  Expanded(
                    child: ListTile(
                      title: Text(_dateOfBirth == null
                          ? 'Select Date of Birth'
                          : 'DOB: ${_dateOfBirth!.toLocal()}'.split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Sex', style: Theme.of(context).textTheme.titleMedium),
              ),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'M',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  Text('M'),
                  SizedBox(width: 20.0),
                  Radio<String>(
                    value: 'F',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  Text('F'),
                  SizedBox(width: 20.0),
                  Radio<String>(
                    value: 'Others',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  Text('Others'),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (cm)'),
                onChanged: (value) => setState(() {
                  _height = value;
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _updateProfile();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
