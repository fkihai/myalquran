import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/bookmark.dart';
import '../../../data/model/surah.dart';

class HomeController extends GetxController {
  RxList<Surah> foundSurah = <Surah>[].obs;
  List<Surah> allSurah = [];

  DatabaseManager databaseManager = DatabaseManager.instance;
  RxMap dataLastRead = {}.obs;
  RxBool isLastRead = false.obs;

  Future<List<Surah>> getAllSurah() async {
    String jsonString = await rootBundle.loadString(
      'assets/surah/all.json',
    );
    List data = json.decode(jsonString);
    if (data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      foundSurah.value = allSurah;
      return allSurah;
    }
  }

  void filterSurah(String surahName) {
    List<Surah> result = [];
    if (surahName.isEmpty) {
      result = allSurah;
    } else {
      result = allSurah
          .where(
            (element) => element.namaLatin.toString().toLowerCase().contains(
                  surahName.toLowerCase(),
                ),
          )
          .toList();
    }
    foundSurah.value = result;
  }

  Future<List> getAllBookmark() async {
    Database db = await databaseManager.db;
    List dataQuery = await db.query(
      'bookmark',
      where: 'lastRead = 0',
    );
    return dataQuery.reversed.toList();
  }

  void deleteBookmark(int id) async {
    Database db = await databaseManager.db;
    await db.delete(
      'bookmark',
      where: 'id=$id',
    );
    update();
  }

  void getLastRead() async {
    Database db = await databaseManager.db;
    List<Map<String, dynamic>> dataQuery = await db.query(
      'bookmark',
      where: 'lastRead = 1',
    );
    if (dataQuery.isNotEmpty) {
      isLastRead.value = true;
      dataLastRead.value = dataQuery.first;
    }
    return;
  }

  @override
  void onInit() {
    getLastRead();
    super.onInit();
  }
}
