import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_input_app/screens/home_page.dart';
import 'screens/medicine_list_screen.dart';
import 'providers/medicine_provider.dart';

void main() {
  runApp(MedicineInventoryApp());
}

class MedicineInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicine Inventory',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(),
      ),
    );
  }
}
