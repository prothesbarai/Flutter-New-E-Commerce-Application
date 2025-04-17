import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_profile.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        city TEXT,
        shipping_address TEXT,
        billing_address TEXT
      )
    ''');
  }

  Future<void> saveUserProfile(String name, String email,String city,String shipping_address,String billing_address) async {
    final db = await instance.database;
    await db.insert(
      'user_profile',
      { 'name':name, 'email':email, 'city':city, 'shipping_address':shipping_address, 'billing_address' :billing_address },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final db = await instance.database;
    final result = await db.query('user_profile', limit: 1);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> updateUserProfile(String name, String email,String city,String shipping_address,String billing_address) async {
    final db = await instance.database;
    await db.update(
      'user_profile',
      { 'name':name, 'email':email, 'city':city, 'shipping_address':shipping_address, 'billing_address' :billing_address },
      where: 'id = ?',
      whereArgs: [1], // Assuming a single user, or you can modify for dynamic IDs
    );
  }
}
