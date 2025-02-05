import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:user_input_app/models/persistence/settings.dart';
import '../db/init_db.dart';
import '../models/persistence/users.dart';
import '../models/persistence/my_profile.dart';
import '../models/persistence/vital_signs.dart';

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

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await InitDB.initializeDatabase(db);
    });
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(String email) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> insertProfile(MyProfile profile) async {
    final db = await instance.database;
    return await db.insert('my_profile', profile.toMap());
  }

  Future<int> updateProfile(MyProfile profile) async {
    final db = await instance.database;
    return await db.update(
      'my_profile',
      profile.toMap(),
      where: 'email = ?',
      whereArgs: [profile.email],
    );
  }

  Future<MyProfile?> getProfile(String email) async {
    final db = await instance.database;
    final result = await db.query('my_profile', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return MyProfile.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> insertVitalSign(VitalSigns vitalSign) async {
    final db = await instance.database;
    return await db.insert('vital_signs', vitalSign.toMap());
  }

  Future<int> updateVitalSign(VitalSigns vitalSign) async {
    final db = await instance.database;
    return await db.update(
      'vital_signs',
      vitalSign.toMap(),
      where: 'id = ?',
      whereArgs: [vitalSign.id],
    );
  }

  Future<List<VitalSigns>> getVitalSigns(String email) async {
    final db = await instance.database;
    final result = await db.query('vital_signs', where: 'email = ?', whereArgs: [email]);

    return result.map((map) => VitalSigns.fromMap(map)).toList();
  }

  Future<int> insertSettings(Settings settings) async {
    final db = await instance.database;
    return await db.insert('settings', settings.toMap());
  }

  Future<int> updateSettings(Settings settings) async {
    final db = await instance.database;
    return await db.update(
      'settings',
      settings.toMap(),
      where: 'email = ?',
      whereArgs: [settings.email],
    );
  }

  Future<Settings?> getSettings(String email) async {
    final db = await instance.database;
    final result = await db.query('settings', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return Settings.fromMap(result.first);
    } else {
      return null;
    }
  }


  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
