import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._private();
  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'quran_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        return await database.execute('''
            CREATE TABLE surah_progress(
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              surah_name_latin TEXT NOT NULL,
              surah_number INTEGER NOT NULL,
              verse_index INTEGER NOT NULL,
              last_read INTEGER DEFAULT 0
            )
          ''');
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
