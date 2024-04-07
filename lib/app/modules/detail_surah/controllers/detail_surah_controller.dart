import 'dart:convert';

import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../../data/db/bookmark.dart';
import '../../../data/model/detail_surah.dart';
import '../../../data/model/surah.dart';
import '../../../data/remote/end_point.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  RxBool isPlayAudio = false.obs;
  DatabaseManager database = DatabaseManager.instance;
  AutoScrollController autoScrollController = AutoScrollController();

  void addBookmark(
    bool lastRead,
    DetailSurah surah,
    Ayat ayat,
    int indexAyat,
  ) async {
    Database db = await database.db;

    if (lastRead) {
      await db.delete('bookmark', where: 'lastread = 1');
    }

    await db.insert(
      "bookmark",
      {
        'nameOfSurah': '${surah.namaLatin}',
        'numberOfSurah': '${surah.nomor}',
        'numberOfVerses': '${ayat.nomor}',
        'indexVersesOnSurah': indexAyat,
        'lastRead': lastRead == true ? 1 : 0,
      },
    );

    Get.back();
  }

  Future<DetailSurah> getAllDetailSurah(Map<String, dynamic> surah) async {
    int? numberOfSurah = surah['numberOfSurah'];
    int? indexVersesOnSurah = surah['indexVersesOnSurah'];
    Uri url = Uri.parse(
      '${EndPoint.baseUrl}${EndPoint.surah}$numberOfSurah',
    );
    var res = await http.get(url);
    Map<String, dynamic> data = json.decode(res.body);
    indexVersesOnSurah == null
        ? null
        : autoScrollController.scrollToIndex(
            indexVersesOnSurah,
            preferPosition: AutoScrollPosition.begin,
          );
    return DetailSurah.fromJson(data);
  }

  Future<List<Surah>> getListSurah() async {
    String jsonString = await rootBundle.loadString(
      'assets/json/allSurah.json',
    );
    List data = json.decode(jsonString);
    if (data.isEmpty) {
      return [];
    } else {
      List<Surah> surahList = data.map((e) => Surah.fromJson(e)).toList();
      return surahList.reversed.toList();
    }
  }

  Future playAudio(String url) async {
    await player.setUrl(url);
    await player.play();
    isPlayAudio.value = false;
  }

  Future stopAudio() async {
    await player.stop();
  }
}
