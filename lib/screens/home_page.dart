import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_input_app/screens/medicine_list_screen.dart';

import '../models/medicine.dart';
import '../providers/medicine_provider.dart';
import 'add_medicine_screen.dart';
import 'custom_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todaysMedicines = context.watch<MedicineProvider>().medicines;
    final List<Medicine> doneMedicines = [];

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Daily dose',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todaysMedicines.length,
              itemBuilder: (context, index) {
                final medicine = todaysMedicines[index];
                return Dismissible(
                  key: Key(medicine.name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      doneMedicines.add(medicine);
                      todaysMedicines.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${medicine.name} marked as done")),
                    );
                  },
                  background: Container(color: Colors.green),
                  child: ListTile(
                    leading: Icon(Icons.medical_services),
                    title: Text(medicine.name),
                    subtitle: Text('Time: ${medicine.expiryDate}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Done',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: doneMedicines.length,
              itemBuilder: (context, index) {
                final medicine = doneMedicines[index];
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(medicine.name),
                  subtitle: Text('Time: ${medicine.expiryDate}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
