import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../providers/medicine_provider.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _selectedDate;

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }

    final newMedicine = Medicine(
      id: DateTime.now().toString(),
      name: _nameController.text,
      type: _typeController.text,
      quantity: int.parse(_quantityController.text),
      expiryDate: _selectedDate!,
    );

    context.read<MedicineProvider>().addMedicine(newMedicine);
    Navigator.pop(context);
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Medicine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Medicine Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration:
                    InputDecoration(labelText: 'Type (e.g., Tablet, Syrup)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Expiry Date: ${_selectedDate!.toLocal()}',
                  ),
                  Spacer(),
                  TextButton(
                    child: Text('Choose Date'),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Add Medicine'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
