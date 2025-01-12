import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  runApp(MyApp());

  //var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  //var initializationSettingsIOS = IOSInitializationSettings();
  //var initializationSettings = InitializationSettings(
    //android: initializationSettingsAndroid,
    //iOS: initializationSettingsIOS,
  //);

 // flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/*Future<void> _showNotification() async {
  /*var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );*/

  //var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  /*var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    //iOS: iOSPlatformChannelSpecifics,
  );*/

  /*await flutterLocalNotificationsPlugin.show(
    0,
    'New Item Added',
    'You have added a new item.',
    platformChannelSpecifics,
    payload: 'item x',
  );*/
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Input App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  List<String> _items = [];

  Future<void> _addItem() async {
     if (_controller.text.isNotEmpty) {
    setState(() {
      _items.add(_controller.text);
      _controller.clear();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', _items);
    //await _showNotification();
  }
  }

  @override
void initState() {
  super.initState();
  _loadItems();
}

Future<void> _loadItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _items = prefs.getStringList('items') ?? [];
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter something'),
            ),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]),
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
