import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/patient_records_screen.dart';
import '../screens/vital_signs_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final String email;

  CustomDrawer({required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text(email),
            currentAccountPicture: GestureDetector(
              onTap: () {
                // Handle profile image change
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientRecordsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Appointments'),
            onTap: () {
              // Navigate to appointments screen
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Prescriptions'),
            onTap: () {
              // Navigate to prescriptions screen
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Billing'),
            onTap: () {
              // Navigate to billing screen
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Navigate to notifications screen
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                  settings: RouteSettings(arguments: email), // Pass the email to ProfileScreen
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
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
