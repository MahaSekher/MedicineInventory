import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _expiryAlert = false;
  int _expiryDays = 0;

  bool _inventoryAlert = false;
  int _inventoryDays = 0;

  bool _appointmentAlert = false;
  int _appointmentMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Notification Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SwitchListTile(
              title: Text('Expiry Alert'),
              value: _expiryAlert,
              onChanged: (value) {
                setState(() {
                  _expiryAlert = value;
                });
              },
            ),
            if (_expiryAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Days before expiry'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _expiryDays = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Inventory Alert'),
              value: _inventoryAlert,
              onChanged: (value) {
                setState(() {
                  _inventoryAlert = value;
                });
              },
            ),
            if (_inventoryAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Days before inventory out'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _inventoryDays = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Appointment Alert'),
              value: _appointmentAlert,
              onChanged: (value) {
                setState(() {
                  _appointmentAlert = value;
                });
              },
            ),
            if (_appointmentAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Minutes before appointment'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _appointmentMinutes = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save settings logic here
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
