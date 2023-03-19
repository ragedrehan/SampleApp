import 'package:sample/user_module/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDatabase {
  UserLocalDatabase._privateConstructor();
  static final UserLocalDatabase instance = UserLocalDatabase._privateConstructor();

  Future<Database> get database async {
    return await UserLocalDatabase.instance.database;
  }

  Future<List<UserModel>> fetchBookmarkUsers() async {
    Database db = await database;
    var users = await db.query('users', orderBy: 'display_name');
    List<UserModel> userList = users.isNotEmpty
        ? users.map((c) => UserModel.fromDBJson(c)).toList()
        : [];
    return userList;
  }

  Future<int> add(UserModel user) async {
    Database db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<int> remove(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'user_id = ?', whereArgs: [id]);
  }
}