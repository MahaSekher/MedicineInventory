import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_medicine_screen.dart';
import 'edit_medicine_screen.dart';
import '../providers/medicine_provider.dart';

class MedicineListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medicines = context.watch<MedicineProvider>().medicines;

    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Inventory'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMedicineScreen()),
              );
            },
          ),
        ],
      ),
      body: medicines.isEmpty
          ? Center(child: Text('No medicines added yet.'))
          : ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final med = medicines[index];
                return ListTile(
                  title: Text(med.name),
                  subtitle: Text(
                      'Type: ${med.type}, Expiry: ${med.expiryDate.toLocal()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditMedicineScreen(medicine: med),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context
                              .read<MedicineProvider>()
                              .deleteMedicine(med.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
