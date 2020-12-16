import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'classes/module.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      // if _database is null we instantiate it
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      p.join(await getDatabasesPath(), 'modules_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE modules(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, grade DOUBLE, credits REAL)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertModule(Module module) async {
    final Database db = await database;
    var table = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM modules");
    module.id = table.first["id"];
    await db.insert(
      'modules',
      module.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// A method that retrieves all the modules from the modules table.
  Future<List<Module>> getAllModules() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('modules');

    return List.generate(maps.length, (i) {
      return Module(
          id: maps[i]['id'],
          name: maps[i]['name'],
          grade: maps[i]['grade'],
          credits: maps[i]['credits']);
    });
  }

  Future<void> updateModule(Module module) async {
    // Get a reference to the database.
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
    // Get a reference to the database.
    final db = await database;

    await db.delete(
      'modules',
      where: "id = ?",
      // Pass the Module's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
