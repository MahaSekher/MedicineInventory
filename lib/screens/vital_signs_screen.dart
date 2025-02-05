import 'package:flutter/material.dart';
import '../models/persistence/vital_signs.dart';
import '../services/database_helper.dart';

class VitalSignsScreen extends StatefulWidget {
  @override
  _VitalSignsScreenState createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  List<VitalSigns> _vitalSignsList = [];
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _temperatureController = TextEditingController();
  String? _emailError;
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);

    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email != null) {
      _loadVitalSigns(email);
    } else {
      // Set error message if email is null
      setState(() {
        _emailError = 'Email not found. Please log in again.';
      });
    }
  }

  Future<void> _loadVitalSigns(String email) async {
    final vitalSigns = await DatabaseHelper.instance.getVitalSigns(email);

    setState(() {
      _vitalSignsList = vitalSigns;
    });
  }

  Future<void> _addVitalSign(String email) async {
    final newVitalSign = VitalSigns(
      email: email,
      date: _dateController.text,
      time: _timeController.text,
      bloodPressure: _bloodPressureController.text,
      heartRate: int.tryParse(_heartRateController.text) ?? 0,
      respiratoryRate: int.tryParse(_respiratoryRateController.text) ?? 0,
      temperature: double.tryParse(_temperatureController.text) ?? 0.0,
    );

    await DatabaseHelper.instance.insertVitalSign(newVitalSign);
    _loadVitalSigns(email);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _bloodPressureController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vital Signs'),
        ),
        body: Center(
          child: Text('Email not found. Please log in again.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vital Signs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: _bloodPressureController,
              decoration: InputDecoration(labelText: 'Blood Pressure'),
            ),
            TextField(
              controller: _heartRateController,
              decoration: InputDecoration(labelText: 'Heart Rate'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _respiratoryRateController,
              decoration: InputDecoration(labelText: 'Respiratory Rate'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _temperatureController,
              decoration: InputDecoration(labelText: 'Temperature'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => _addVitalSign(email),
              child: Text('Add Vital Sign'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _vitalSignsList.length,
                itemBuilder: (context, index) {
                  final vitalSign = _vitalSignsList[index];
                  return ListTile(
                    title: Text('${vitalSign.date} - ${vitalSign.time}'),
                    subtitle: Text(
                      'BP: ${vitalSign.bloodPressure}, HR: ${vitalSign.heartRate}, RR: ${vitalSign.respiratoryRate}, Temp: ${vitalSign.temperature}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
