import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'classes/module.dart';
import 'classes/GoalCAP.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      // if _database is null we initiate it
      _database = await createDatabase();
      return _database;
    }
  }

  Future _create(Database database, int version) async {
    await database.execute(
        "CREATE TABLE modules (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, grade DOUBLE, credits REAL, done INTEGER)");
    await database
        .execute("CREATE TABLE goalcap (id INTEGER PRIMARY KEY, goal DOUBLE)");
  }

  createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String databasesPath = await getDatabasesPath();
    String dbPath = p.join(databasesPath, 'my.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: _create);
    return database;
  }

  Future<void> insertModule(Module module) async {
    //insets new module into DB
    final Database db = await database;
    var table = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM modules");
    module.id = table.first["id"];
    await db.insert(
      'modules',
      module.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Module>> getAllModules() async {
    // used to get all Modules from SQLite DB
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('modules');

    return List.generate(maps.length, (i) {
      return Module(
          id: maps[i]['id'],
          name: maps[i]['name'],
          grade: maps[i]['grade'],
          credits: maps[i]['credits'].toInt(),
          done: maps[i]['done']);
    });
  }

  Future<void> updateModule(Module module) async {
    // takes a new module and replaces old module by matching their ids
    final db = await database;

    // Update the given Module.
    await db.update(
      'modules',
      module.toMap(),
      where: "id = ?",
      // Pass the Modules's id as a whereArg to prevent SQL injection.
      whereArgs: [module.id],
    );
  }

  Future<void> deleteModule(int id) async {
    // deletes module by matching the id
    final db = await database;

    await db.delete(
      'modules',
      where: "id = ?",
      // Pass the Module's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  deleteAll() async {
    final db = await database;
    await db.rawDelete("Delete from modules");
  }

  Future<void> insertGoalCAP(GoalCAP goalCAP) async {
    //insets new module into DB
    final Database db = await database;
    await db.insert(
      'goalcap',
      goalCAP.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGoalCAP() async {
    // delete goal CAP by matching the id
    final db = await database;

    await db.delete(
      "goalcap",
      where: "id = ?",
      // Pass the Module's id as a whereArg to prevent SQL injection.
      whereArgs: [0],
    );
  }

  Future<void> updateGoalCAP(GoalCAP goalCAP) async {
    // takes a new goal CAP and replaces old goal CAP by matching their ids
    print("UPDATE DB GOAL CAP");
    final db = await database;
    // Update the given Module.
    await db.update(
      "goalcap",
      goalCAP.toMap(),
      where: "id = ?",
      // Pass the Modules's id as a whereArg to prevent SQL injection.
      whereArgs: [goalCAP.getGoalCapId()],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // GoalCAP gc = await getGoalCAP();
    // print("WAT " + gc.getGoalCap().toString());
  }

  Future<GoalCAP> getGoalCAP() async {
    // used to get goal CAP from SQLite DB;
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('goalcap');
    print("MAP: " + maps.toString());
    return maps.isEmpty ? GoalCAP(goal: 0.0) : GoalCAP(goal: maps[0]["goal"]);
  }
}

//
// void _createGoalCapTableV1toV2(Batch batch) {
//   batch.execute(
//       "CREATE TABLE goalcap (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, goal DOUBLE)");
// }
//
// initDB() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   return await openDatabase(
//       p.join(await getDatabasesPath(), 'modules_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE modules(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, grade DOUBLE, credits REAL, done INTEGER)",
//         );
//       },
//       version: 1,
//       onUpgrade: (db, oldVersion, newVersion) async {
//         var batch = db.batch();
//         if (oldVersion == 1) {
//           _createGoalCapTableV1toV2(batch);
//         }
//         await batch.commit();
//       });
// }
