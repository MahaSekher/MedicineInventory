import 'package:sqflite/sqflite.dart';

class InitDB {
  static Future<void> initializeDatabase(Database db) async {
    await db.execute('''
      CREATE TABLE users (
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
        dob DATE,
        gender TEXT,
        height FLOAT,
        weight FLOAT,
        image TEXT,
        FOREIGN KEY(email) REFERENCES users(email)
      );
    ''');
  }
}
