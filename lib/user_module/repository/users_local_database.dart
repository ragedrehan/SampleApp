import 'dart:io';
import 'package:sample/user_module/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
          user_id INTEGER PRIMARY KEY,
          display_name TEXT,
          profile_image TEXT,
          location TEXT
      )
      ''');
  }

  Future<List<UserModel>> fetchBookmarkUsers() async {
    Database db = await instance.database;
    var users = await db.query('users', orderBy: 'display_name');
    List<UserModel> userList = users.isNotEmpty
        ? users.map((c) => UserModel.fromDBJson(c)).toList()
        : [];
    return userList;
  }

  Future<int> add(UserModel user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toJson());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('users', where: 'user_id = ?', whereArgs: [id]);
  }
}
