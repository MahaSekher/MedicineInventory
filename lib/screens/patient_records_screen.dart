import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';

class PatientRecordsScreen extends StatefulWidget {
  @override
  _PatientRecordsScreenState createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  final _formKey = GlobalKey<FormState>();

  String _medicalHistory = '';
  String _medications = '';
  String _labResults = '';
  String _progressNotes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Records')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Medical History'),
                maxLines: 5,
                onChanged: (value) {
                  _medicalHistory = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Medications'),
                maxLines: 3,
                onChanged: (value) {
                  _medications = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lab Results'),
                maxLines: 5,
                onChanged: (value) {
                  _labResults = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Progress Notes'),
                maxLines: 5,
                onChanged: (value) {
                  _progressNotes = value;
                },
              ),
              SizedBox(height: 20),
              RoundedButton(
                text: 'Save',
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save patient records logic here
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
