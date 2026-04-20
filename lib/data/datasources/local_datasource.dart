import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myalquran/data/datasources/database_manager.dart';
import 'package:myalquran/data/models/surah_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/surah_progress_model.dart';

class LocalDatasource {
  final DatabaseManager database;
  LocalDatasource(this.database);

  Future<void> addBookmark(SurahProgressModel verses) async {
    Database db = await database.db;
    await db.insert("surah_progress", verses.toJson());
  }

  Future<void> addLastRead(SurahProgressModel verses) async {
    Database db = await database.db;

    if (verses.lastRead) {
      await db.delete('surah_progress', where: 'last_read = 1');
    }

    await db.insert('surah_progress', verses.toJson());
  }

  Future<List<SurahProgressModel>> getAllBookmark() async {
    Database db = await database.db;
    final List data = await db.query('bookmark', where: 'lastread = 0');
    List<SurahProgressModel> bookmarks =
        data.map((e) => SurahProgressModel.fromjson(e)).toList();

    return bookmarks;
  }

  Future<SurahProgressModel> getLastRead() async {
    Database db = await database.db;
    final List data =
        await db.query('bookmark', where: 'lastread = ?', whereArgs: [0]);
    List<SurahProgressModel> bookmarks =
        data.map((e) => SurahProgressModel.fromjson(e)).toList();

    return bookmarks.first;
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
