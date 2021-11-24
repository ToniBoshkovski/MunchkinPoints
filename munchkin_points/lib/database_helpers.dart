import 'dart:io';

import 'package:munchkin_points/globals.dart';
import 'package:munchkin_points/models/game_counter.dart';
import 'package:munchkin_points/models/player.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = "munchkin_points_$_databaseVersion.db";

  // Increment this version when you need to change the schema.
  static const _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tablePlayers (
                $columnId INTEGER PRIMARY KEY,
                $columnName TEXT NULL,
                $columnPoints INT NULL
              );
              ''');

    await db.execute('''
              CREATE TABLE $tableGameCounter (
                $columnId INTEGER PRIMARY KEY,
                $columnElapsedTime INT NULL
              );
              ''');
  }

  Future insertPlayer(Player player) async {
    Database db = await database;
    await db.insert(tablePlayers, player.toDbMap());
  }

  Future getPlayer(int id) async {
    Database db = await database;
    final maps = await db.query(
      tablePlayers,
      columns: null,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Player.fromDbMap(maps.first);
    }
    return null;
  }

  Future<List<Player>> getAllPlayers() async {
    List<Player> listOfPlayers = <Player>[];
    Database db = await database;
    final maps = await db.query(tablePlayers);
    if (maps.isNotEmpty) {
      for (var map in maps) {
        listOfPlayers.add(Player.fromDbMap(map));
      }
    }
    return listOfPlayers;
  }

  Future updatePlayer(Player player) async {
    Database db = await database;
    await db.update(
      tablePlayers,
      player.toDbMap(),
      where: '$columnId = ?',
      whereArgs: [player.id],
    );
  }

  Future deletePlayer(int id) async {
    Database db = await database;
    await db.delete(
      tablePlayers,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future deleteAllPlayers() async {
    Database db = await database;
    await db.delete(tablePlayers);
  }

  Future insertGameCounter(GameCounter counter) async {
    Database db = await database;
    await db.insert(tableGameCounter, counter.toDbMap());
  }

  Future getGameCounter() async {
    Database db = await database;
    final maps = await db.query(tableGameCounter);
    if (maps.isNotEmpty) {
      return GameCounter.fromDbMap(maps.first);
    }
    return null;
  }

  Future deleteGameCounter() async {
    Database db = await database;
    await db.delete(tableGameCounter);
  }
}
