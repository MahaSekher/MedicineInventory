import 'package:sqflite/sqflite.dart';

class InitDB {
  static Future<void> initializeDatabase(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        name TEXT NOT NULL,
        email TEXT PRIMARY KEY,
        password TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE my_profile (
        email TEXT PRIMARY KEY,
        name TEXT,
        phone TEXT,
        address TEXT,
        emergency_contact TEXT,
        dob TEXT,
        gender TEXT,
        height REAL,
        weight REAL,
        image TEXT,
        FOREIGN KEY(email) REFERENCES users(email)
      );
    ''');

    await db.execute('''
      CREATE TABLE vital_signs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        date TEXT,
        time TEXT,
        temperature REAL,
        blood_pressure TEXT,
        heart_rate INTEGER,
        respiratory_rate INTEGER,
        FOREIGN KEY(email) REFERENCES users(email)
      );
    ''');

    await db.execute('''
      CREATE TABLE settings (
        email TEXT PRIMARY KEY,
        expiry_alert INTEGER,
        expiry_days INTEGER,
        inventory_alert INTEGER,
        inventory_days INTEGER,
        appointment_alert INTEGER,
        appointment_minutes INTEGER,
        FOREIGN KEY(email) REFERENCES users(email)
      );
    ''');
  }
}
