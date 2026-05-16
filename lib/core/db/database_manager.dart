import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._private();
  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  static const String tableBookmarks = 'bookmarks';
  static const String tableLastRead = 'last_read';

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'quran_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (database, version) async {
        await database.execute('''
            CREATE TABLE $tableBookmarks(
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              surah_id INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              juz_number INTEGER NOT NULL,
              surah_name TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');

        await database.execute('''
            CREATE TABLE $tableLastRead(
              id INTEGER PRIMARY KEY CHECK (id = 1),
              surah_id INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              juz_number INTEGER NOT NULL,
              surah_name TEXT NOT NULL,
              updated_at TEXT NOT NULL
            )
          ''');
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await database.execute('DROP TABLE IF EXISTS surah_progress');
          // Re-trigger onCreate logic for the new tables
          await database.execute('''
            CREATE TABLE $tableBookmarks(
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              surah_id INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              juz_number INTEGER NOT NULL,
              surah_name TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');
          await database.execute('''
            CREATE TABLE $tableLastRead(
              id INTEGER PRIMARY KEY CHECK (id = 1),
              surah_id INTEGER NOT NULL,
              verse_number INTEGER NOT NULL,
              juz_number INTEGER NOT NULL,
              surah_name TEXT NOT NULL,
              updated_at TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
