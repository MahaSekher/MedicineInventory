import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('emr_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE patients (
        id $idType,
        name $textType,
        dob $textType,
        gender $textType,
        phone_number $textType,
        address $textType
      )
    ''');
  }

  Future<void> insertPatient(Map<String, dynamic> patient) async {
    final db = await instance.database;
    await db.insert('patients', patient);
  }

  Future<List<Map<String, dynamic>>> getAllPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
