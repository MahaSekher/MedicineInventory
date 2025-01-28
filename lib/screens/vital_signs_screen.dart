import 'package:flutter/material.dart';

class VitalSignsScreen extends StatefulWidget {
  @override
  _VitalSignsScreenState createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

  String _bloodPressure = '';
  String _heartRate = '';
  String _temperature = '';
  String _respiratoryRate = '';
  String _prePrandialBloodGlucose = '';
  String _postPrandialBloodGlucose = '';
  String _randomBloodSugar = '';
  String _weight = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vital Signs')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Blood Pressure'),
                onChanged: (value) => setState(() {
                  _bloodPressure = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Heart Rate'),
                onChanged: (value) => setState(() {
                  _heartRate = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Temperature'),
                onChanged: (value) => setState(() {
                  _temperature = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Respiratory Rate'),
                onChanged: (value) => setState(() {
                  _respiratoryRate = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Blood Glucose Level (Pre Prandial)'),
                onChanged: (value) => setState(() {
                  _prePrandialBloodGlucose = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Blood Glucose Level (Post Prandial)'),
                onChanged: (value) => setState(() {
                  _postPrandialBloodGlucose = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Random Blood Sugar'),
                onChanged: (value) => setState(() {
                  _randomBloodSugar = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                onChanged: (value) => setState(() {
                  _weight = value;
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save vital signs data logic here
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
