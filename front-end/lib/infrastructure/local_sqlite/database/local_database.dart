import 'dart:async';
import 'package:crime_reporter/infrastructure/local_sqlite/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CrimeDb {
  late Database database;

  Future initDB() async {
    if (database != null) {
      return database;
    }

    String databasesPath = await getDatabasesPath();

    database = await openDatabase(
      join(databasesPath, 'crime.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(title TEXT,  location TEXT, time TEXT, description TEXT, imageURL TEXT ,report_to TEXT ,status TEXT, reporter TEXT,)",
        );
      },
      version: 1,
    );

    return database;
  }

  Future<void> insertUser(User user) async {
    final Database db = await database;

    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
  }

   Future<void> inserCrime(User user) async {
    final Database db = await database;

    await db.insert(
      'crime',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
  }

  Future<List<User>> user() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('trans');

    return List.generate(maps.length, (i) {
      return User(
        fullname: maps[i]['fullname'],
        imageURL: maps[i]['imageURL'],
        email: maps[i]['email'],
        phone_no: maps[i]['phone_no'],
        password: maps[i]['password'],
        role: maps[i]['role'],
        location: maps[i]['location'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;

    await db.update(
      'user',
      user.toMap(),
      where: "password = ?",
      whereArgs: [user.password],
    );
  }

  Future<void> deleteUser(int password) async {
    final db = await database;

    await db.delete(
      'user',
      where: "password = ?",
      whereArgs: [password],
    );
  }
}
