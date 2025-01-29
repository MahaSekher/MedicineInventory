import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('emr_db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final docDirectory = await getApplicationDocumentsDirectory();
    final path = join(docDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Patient Table
    await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        dob TEXT,
        gender TEXT,
        phone_number TEXT,
        address TEXT
      )
    ''');

    // Medical Record Table
    await db.execute('''
      CREATE TABLE medical_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER,
        diagnosis TEXT,
        treatment TEXT,
        record_date TEXT,
        FOREIGN KEY (patient_id) REFERENCES patients(id)
      )
    ''');

    // Appointment Table
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER,
        appointment_date TEXT,
        doctor_name TEXT,
        FOREIGN KEY (patient_id) REFERENCES patients(id)
      )
    ''');
  }

  // Insert Patient
  Future<int> insertPatient(Map<String, dynamic> patient) async {
    final db = await instance.database;
    return await db.insert('patients', patient);
  }

  // Insert Medical Record
  Future<int> insertMedicalRecord(Map<String, dynamic> record) async {
    final db = await instance.database;
    return await db.insert('medical_records', record);
  }

  // Insert Appointment
  Future<int> insertAppointment(Map<String, dynamic> appointment) async {
    final db = await instance.database;
    return await db.insert('appointments', appointment);
  }

  // Get all patients
  Future<List<Map<String, dynamic>>> getAllPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  // Get all medical records
  Future<List<Map<String, dynamic>>> getMedicalRecords(int patientId) async {
    final db = await instance.database;
    return await db.query('medical_records',
        where: 'patient_id = ?', whereArgs: [patientId]);
  }

  // Get all appointments
  Future<List<Map<String, dynamic>>> getAppointments(int patientId) async {
    final db = await instance.database;
    return await db
        .query('appointments', where: 'patient_id = ?', whereArgs: [patientId]);
  }
}
