import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/Crime_models/report.dart';
import '../../domain/User_models/user.dart';

class CrimeDb {
  late Database database;

// initializing the database
  Future initDB() async {
    String databasesPath = await getDatabasesPath();
    database = await openDatabase(
      join(databasesPath, 'crime_reporter.db'),
      onCreate: _createDb,
      version: 1,
    );
    return database;
  }

  Future _createDb(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE user(
          fullname TEXT, 
          pasword TEXT,
          email  TEXT,
          imgUrl TEXT ,
          role TEXT ,
          PhoneNo TEXT, 
          )''',
    );

    await db.execute(
      '''CREATE TABLE crime(
          title TEXT, 
          location TEXT,
          time TEXT,
          description TEXT,
          imageURL TEXT ,
          report_to TEXT ,
          status TEXT, 
          reporter TEXT,)''',
    );

   
  }

// creating user table
  Future<void> insertUser(User user) async {
    final Database db = database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// creating crime table
  Future<void> inserCrime(Report crime) async {
    final Database db = database;
    await db.insert(
      'crime',
      crime.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // user crud operations
  Future<List<User>> getusers() async {
    final Database db = database;
    final List<Map<String, dynamic>> maps = await db.query('trans');
    return List.generate(maps.length, (i) {
      return User(
        userId: maps[i]['userId'],
        fullname: maps[i]['fullname'],
        imgUrl: maps[i]['imageURL'],
        email: maps[i]['email'],
        phoneNo: maps[i]['phoneNo'],
        password: maps[i]['password'],
        role: maps[i]['role'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = database;
    await db.update(
      'user',
      user.toMap(),
      where: "password = ?",
      whereArgs: [user.password],
    );
  }

  Future<void> deleteUser(int password) async {
    final db = database;
    await db.delete(
      'user',
      where: "password = ?",
      whereArgs: [password],
    );
  }

// crime crud operations
  Future<List<Report>> getCrimes() async {
    final Database db = database;
    final List<Map<String, dynamic>> maps = await db.query('trans');
    return List.generate(maps.length, (i) {
      return Report(
          reportTo: maps[i]['reportTo'],
          time: maps[i]['time'],
          location: maps[i]['location'],
          reporter: maps[i]['reporter'],
          description: maps[i]['description'],
          imageURL: maps[i]['imageURL'],
          crimeId: maps[i]['_id'],
          title: maps[i]['title'],
          status: maps[i]['status']);
    });
  }

  Future<void> updateCrime(Report crime) async {
    final db = database;
    await db.update(
      'crime',
      crime.toMap(),
      where: "_id = ?",
      whereArgs: [crime.crimeId],
    );
  }

  Future<void> deleteCrime(int id) async {
    final db = database;
    await db.delete(
      'crime',
      where: "id = ?",
      whereArgs: [id],
    );
  }


  
}
