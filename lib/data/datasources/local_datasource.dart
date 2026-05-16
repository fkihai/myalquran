import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myalquran/core/db/database_manager.dart';
import 'package:myalquran/data/models/bookmark_model.dart';
import 'package:myalquran/data/models/juz_model.dart';
import 'package:myalquran/data/models/last_read_model.dart';
import 'package:myalquran/data/models/surah_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  final DatabaseManager database;
  final _dbStreamController = StreamController<void>.broadcast();

  LocalDatasource(this.database);

  Stream<void> get databaseStream => _dbStreamController.stream;

  Future<void> addBookmark(BookmarkModel bookmark) async {
    Database db = await database.db;
    await db.insert(
      DatabaseManager.tableBookmarks,
      bookmark.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _dbStreamController.add(null);
  }

  Future<void> addLastRead(LastReadModel lastRead) async {
    Database db = await database.db;
    await db.insert(
      DatabaseManager.tableLastRead,
      lastRead.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _dbStreamController.add(null);
  }

  Future<void> deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete(
      DatabaseManager.tableBookmarks,
      where: 'id = ?',
      whereArgs: [id],
    );
    _dbStreamController.add(null);
  }

  Future<List<BookmarkModel>> getAllBookmark() async {
    Database db = await database.db;
    final List<Map<String, dynamic>> data =
        await db.query(DatabaseManager.tableBookmarks);
    final bookmarks = data.map((e) => BookmarkModel.fromJson(e)).toList();
    return bookmarks;
  }

  Future<LastReadModel?> getLastRead() async {
    Database db = await database.db;
    final data = await db.query(DatabaseManager.tableLastRead);
    if (data.isEmpty) return null;
    return LastReadModel.fromJson(data.first);
  }

  Future<SurahModel> getVersesOfSurah({required int surahNumber}) async {
    String jsonString = await rootBundle.loadString(
      'assets/surah/$surahNumber.json',
    );

    Map<String, dynamic> data = json.decode(jsonString);
    return SurahModel.fromJson(data);
  }

  Future<List<SurahModel>> getSurahList() async {
    String jsonString = await rootBundle.loadString('assets/surah/all.json');

    final List<dynamic> data = json.decode(jsonString);

    List<SurahModel> allSurah = data
        .map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return allSurah;
  }

  Future<List<Juz>> geJuzList() async {
    return [];
  }
}
