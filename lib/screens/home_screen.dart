import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the EMR App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              'Today\'s Appointments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('John Doe'),
                    subtitle: Text('10:00 AM'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                  ListTile(
                    title: Text('Jane Smith'),
                    subtitle: Text('11:30 AM'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListTile(
              title: Text('New lab results available for John Doe'),
              leading: Icon(Icons.notification_important, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
