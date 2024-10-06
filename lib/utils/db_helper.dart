// ignore_for_file: avoid_print

import 'dart:io';
//import 'dart:js_util';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//import 'dart:convert';
import 'package:mp5/model/recipe.dart';




class DBHelper {
  static const String _databaseName = 'kitchenify.db';
  static const int _databaseVersion = 1;

  DBHelper._(); // Private constructor for singleton pattern

  static final DBHelper _singleton = DBHelper._();

  factory DBHelper() => _singleton;

  Database? _database;

  Future<Database> get db async {
    _database ??= await initDatabase();
   print("_database (object): $_database"); // Print the object itself
   print("_database (path): ${_database?.path}");
    return _database!;
  }

  void close() async {
    await _database?.close(); // Close DB if open
    _database = null; // Set DB instance to null after closing
  }

  Future<Database> initDatabase() async {
    var dbDir = await getApplicationDocumentsDirectory();
    print("dbDir: $dbDir");
    var dbPath = path.join(dbDir.path, _databaseName);
    print("dbpath: $dbPath");   
    var databaseFile = File(dbPath);
    print("dbFile: $databaseFile");
    var databaseExists = await databaseFile.exists();
    print("databaseExists: $databaseExists");
    
    if (!databaseExists) {
      print("inside db exists");
      var initializedDb = await createAndInitializeDatabase(dbPath);
      print("init DB: $initializedDb");
      return initializedDb;
    }

    var db = await openDatabase(
      dbPath,
      version: _databaseVersion,
    );
    print("db: $db");
    return db;
  }

  Future<bool> doesDatabaseExist(String dbPath) async {
    return File(dbPath).exists();
  }

  
  Future<Database> createAndInitializeDatabase(String dbPath) async {
  try {
    var db = await openDatabase(
      dbPath,
      version: _databaseVersion + 1,
      onCreate: (Database db, int version) async {
        print("Creating tables...");

        await db.execute('''
          CREATE TABLE recipes(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT
          );
        ''');
      },
    );
    await _prepopulateDatabase(db);

    return db;
  } catch (e) {
    print("Error creating database: $e");
    // Handle the error appropriately, e.g., display an error message to the user
    // Or throw an exception
    throw Exception("Failed to create database: $e");
  }
}

    // Prepopulate the database with sample data
    // You can replace this with your actual data loading mechanism

  Future<void> _prepopulateDatabase(Database db) async {


    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO recipes(name, description) VALUES(?, ?)',
          ['Pasta', 'This is a special varity of Pasta']);
      await txn.rawInsert(
          'INSERT INTO recipes(name, description) VALUES(?, ?)',
          ['Pizza', 'This is a special varity of Pizza']);
    });
    
  }

  Future<int> insertRecipe(String name, String description) async {
    final db = await this.db;
    var result = await db.rawInsert(
        'INSERT INTO recipes(name, description) VALUES(?, ?)',
        [name, description]);
    return result;
  }

  Future<List<Recipe>> getRecipe() async {
    final db = await this.db;
    var res = await db.rawQuery("SELECT * FROM recipes");
    List<Recipe> list = [];
    for (var item in res) {
      list.add(Recipe.fromMap(item));
    }
    return list;
  }

  Future<int> deleteRecipe(int id) async {
    final db = await this.db;
    return await db.rawDelete('DELETE FROM recipes WHERE id = ?', [id]);
  }
}