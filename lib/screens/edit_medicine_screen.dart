import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../providers/medicine_provider.dart';

class EditMedicineScreen extends StatefulWidget {
  final Medicine medicine;

  EditMedicineScreen({required this.medicine});

  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _quantityController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine.name);
    _typeController = TextEditingController(text: widget.medicine.type);
    _quantityController =
        TextEditingController(text: widget.medicine.quantity.toString());
    _selectedDate = widget.medicine.expiryDate;
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }

    final updatedMedicine = Medicine(
      id: widget.medicine.id,
      name: _nameController.text,
      type: _typeController.text,
      quantity: int.parse(_quantityController.text),
      expiryDate: _selectedDate!,
    );

    context
        .read<MedicineProvider>()
        .updateMedicine(widget.medicine.id, updatedMedicine);

    Navigator.pop(context);
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
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
      appBar: AppBar(title: Text('Edit Medicine')),
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
                child: Text('Update Medicine'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
