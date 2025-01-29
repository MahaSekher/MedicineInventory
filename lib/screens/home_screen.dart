import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../models/user_profile.dart';
import '../models/persistence/appointment.dart';
import '../models/persistence/medical_record.dart';
import '../models/persistence/patient.dart';
import '../models/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

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

class _HomeScreenState extends State<HomeScreen> {
  final _patientNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  // Function to save patient data
  Future<void> _savePatient() async {
    final patient = Patient(
      name: _patientNameController.text,
      dob: _dobController.text,
      gender: 'Male', // Example: hardcoded, you can extend this to input
      phoneNumber: _phoneController.text,
      address: _addressController.text,
    );

    await DatabaseHelper.instance.insertPatient(patient.toMap());
    _clearFields();
    setState(() {});
  }

  // Clear input fields
  void _clearFields() {
    _patientNameController.clear();
    _dobController.clear();
    _phoneController.clear();
    _addressController.clear();
  }

  // Function to fetch patients
  Future<List<Patient>> _fetchPatients() async {
    final List<Map<String, dynamic>> patientsData =
        await DatabaseHelper.instance.getAllPatients();
    return List.generate(patientsData.length, (i) {
      return Patient(
        id: patientsData[i]['id'],
        name: patientsData[i]['name'],
        dob: patientsData[i]['dob'],
        gender: patientsData[i]['gender'],
        phoneNumber: patientsData[i]['phone_number'],
        address: patientsData[i]['address'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electronic Medical Records')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _patientNameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth')),
            TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number')),
            TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _savePatient, child: Text('Save Patient')),
            SizedBox(height: 20),
            FutureBuilder<List<Patient>>(
              future: _fetchPatients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No patients found.');
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final patient = snapshot.data![index];
                      return ListTile(
                        title: Text(patient.name),
                        subtitle: Text('DOB: ${patient.dob}'),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
