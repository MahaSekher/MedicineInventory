import 'package:flutter/material.dart';
import '../models/persistence/settings.dart';
import '../services/database_helper.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings _settings;
  final _expiryAlertController = TextEditingController();
  final _expiryDaysController = TextEditingController();
  final _inventoryAlertController = TextEditingController();
  final _inventoryDaysController = TextEditingController();
  final _appointmentAlertController = TextEditingController();
  final _appointmentMinutesController = TextEditingController();
  String? _emailError;
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);

    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email != null) {
      _loadSettings(email);
    } else {
      // Set error message if email is null
      setState(() {
        _emailError = 'Email not found. Please log in again.';
      });
    }
  }

  Future<void> _loadSettings(String email) async {
    final settings = await DatabaseHelper.instance.getSettings(email);

    if (settings != null) {
      setState(() {
        _settings = settings;

        _expiryAlertController.text = settings.expiryAlert.toString();
        _expiryDaysController.text = settings.expiryDays.toString();
        _inventoryAlertController.text = settings.inventoryAlert.toString();
        _inventoryDaysController.text = settings.inventoryDays.toString();
        _appointmentAlertController.text = settings.appointmentAlert.toString();
        _appointmentMinutesController.text = settings.appointmentMinutes.toString();
      });
    } else {
      setState(() {
        _settings = Settings(
          email: email,
          expiryAlert: false,
          expiryDays: 0,
          inventoryAlert: false,
          inventoryDays: 0,
          appointmentAlert: false,
          appointmentMinutes: 0,
        );
      });
    }
  }

  Future<void> _saveSettings() async {
    final updatedSettings = _settings.copyWith(
      expiryAlert: _expiryAlertController.text == 'true',
      expiryDays: int.tryParse(_expiryDaysController.text) ?? 0,
      inventoryAlert: _inventoryAlertController.text == 'true',
      inventoryDays: int.tryParse(_inventoryDaysController.text) ?? 0,
      appointmentAlert: _appointmentAlertController.text == 'true',
      appointmentMinutes: int.tryParse(_appointmentMinutesController.text) ?? 0,
    );

    await DatabaseHelper.instance.updateSettings(updatedSettings);

    setState(() {
      _settings = updatedSettings;
    });
  }

  @override
  void dispose() {
    _expiryAlertController.dispose();
    _expiryDaysController.dispose();
    _inventoryAlertController.dispose();
    _inventoryDaysController.dispose();
    _appointmentAlertController.dispose();
    _appointmentMinutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Text('Email not found. Please log in again.'),
        ),
      );
    }

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
              value: _settings.expiryAlert,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(expiryAlert: value);
                });
              },
            ),
            if (_settings.expiryAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _expiryDaysController,
                  decoration: InputDecoration(labelText: 'Days before expiry'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _settings = _settings.copyWith(expiryDays: int.tryParse(value) ?? 0);
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Inventory Alert'),
              value: _settings.inventoryAlert,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(inventoryAlert: value);
                });
              },
            ),
            if (_settings.inventoryAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _inventoryDaysController,
                  decoration: InputDecoration(labelText: 'Days before inventory out'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _settings = _settings.copyWith(inventoryDays: int.tryParse(value) ?? 0);
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Appointment Alert'),
              value: _settings.appointmentAlert,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(appointmentAlert: value);
                });
              },
            ),
            if (_settings.appointmentAlert)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _appointmentMinutesController,
                  decoration: InputDecoration(labelText: 'Minutes before appointment'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _settings = _settings.copyWith(appointmentMinutes: int.tryParse(value) ?? 0);
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveSettings(),
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
