import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../db/init_db.dart';
import '../models/persistence/users.dart';
import '../models/persistence/my_profile.dart';

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

  Future<User?> getUser(String email) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
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

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
