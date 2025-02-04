import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure the email is not null
    final String email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    if (email.isEmpty) {
      // If email is empty, navigate back to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(email: email),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
