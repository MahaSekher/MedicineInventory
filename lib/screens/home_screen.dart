import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../services/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _email;
  late String _name = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    if (email.isNotEmpty) {
      _email = email;
      _loadUserName(email);
    } else {
      // If email is empty, navigate back to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  Future<void> _loadUserName(String email) async {
    final user = await DatabaseHelper.instance.getUser(email);

    if (user != null) {
      setState(() {
        _name = user.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(email: _email, name: _name),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
