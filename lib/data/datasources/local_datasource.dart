import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myalquran/data/datasources/database_manager.dart';
import 'package:myalquran/data/models/surah_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/surah_progress_model.dart';

class LocalDatasource {
  final DatabaseManager database;
  final _dbStreamController = StreamController<void>.broadcast();

  LocalDatasource(this.database);

  Stream<void> get databaseStream => _dbStreamController.stream;

  Future<void> addBookmark(SurahProgressModel verses) async {
    Database db = await database.db;
    await db.insert("surah_progress", verses.toJson());
    _dbStreamController.add(null);
  }

  Future<void> addLastRead(SurahProgressModel verses) async {
    Database db = await database.db;

    if (verses.lastRead) {
      await db.delete('surah_progress', where: 'last_read = 1');
    }

    await db.insert('surah_progress', verses.toJson());
    _dbStreamController.add(null);
  }

  Future<void> deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete('surah_progress', where: 'id = ?', whereArgs: [id]);
    _dbStreamController.add(null);
  }


  Future<List<SurahProgressModel>> getAllBookmark() async {
    Database db = await database.db;
    final List<Map<String, dynamic>> data =
        await db.query('surah_progress', where: 'last_read = 0');
    List<SurahProgressModel> bookmarks =
        data.map((e) => SurahProgressModel.fromjson(e)).toList();

    return bookmarks;
  }

  Future<SurahProgressModel?> getLastRead() async {
    Database db = await database.db;
    final List<Map<String, dynamic>> data =
        await db.query('surah_progress', where: 'last_read = 1');
    
    if (data.isEmpty) return null;
    
    return SurahProgressModel.fromjson(data.first);
  }

  Future<SurahModel> getDetailSurah({required int surahNumber}) async {
    String jsonString = await rootBundle.loadString(
      'assets/surah/$surahNumber.json',
    );

    Map<String, dynamic> data = json.decode(jsonString);
    return SurahModel.fromJson(data);
  }

  Future<List<SurahModel>> getAllSurah() async {
    String jsonString = await rootBundle.loadString('assets/surah/all.json');

    final List<dynamic> data = json.decode(jsonString);

    List<SurahModel> allSurah = data
        .map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return allSurah;
  }
}
