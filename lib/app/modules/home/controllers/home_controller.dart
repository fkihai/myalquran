import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../../data/db/bookmark.dart';
import '../../../data/model/surah.dart';
import '../../../data/remote/end_point.dart';

class HomeController extends GetxController {
  RxList<Surah> foundSurah = <Surah>[].obs;
  List<Surah> allSurah = [];
  DatabaseManager databaseManager = DatabaseManager.instance;

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse('${EndPoint.baseUrl}${EndPoint.surah}');
    var res = await http.get(url);

    List data = json.decode(res.body);

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

    return dataQuery;
  }

  void deleteBookmark(int id) async {
    Database db = await databaseManager.db;
    await db.delete(
      'bookmark',
      where: 'id=$id',
    );
    update();
  }
}
