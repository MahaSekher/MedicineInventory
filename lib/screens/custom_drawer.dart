// custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:user_input_app/screens/home_page.dart';
import 'package:user_input_app/screens/medicine_list_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('mahalakshmi'),
            accountEmail: Text('mahalakshmi.sekar@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('hello'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Medicine list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicineListScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.face_2),
            title: Text('My account'),
            /*onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },*/
          ),ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            /*onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },*/
          ),
        ],
      ),
    );
  }
}
