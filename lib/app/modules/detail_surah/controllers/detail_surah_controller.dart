import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myalquran/app/data/remote/end_point.dart';
import 'package:myalquran/app/modules/home/controllers/home_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:sqflite/sqflite.dart';
import '../../../data/db/bookmark.dart';
import '../../../data/model/detail_surah.dart';
import '../../../data/model/surah.dart';
import '../../utils/convert_string_index.dart';
import '../../utils/internet_check.dart';
import '../../utils/snackbar_message.dart';

class DetailSurahController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final player = AudioPlayer();
  late TabController tabController;
  DatabaseManager database = DatabaseManager.instance;
  AutoScrollController autoScrollController = AutoScrollController();

  RxInt currentIndexTab = 0.obs;
  RxBool isPlayAudio = false.obs;
  String indexUrl = "";

  final Map<String, dynamic> surahArgument = Get.arguments;
  late int numberOfSurah = surahArgument['numberOfSurah'];

  final lastreadController = Get.put(HomeController());

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

    // Update Lastread
    lastreadController.getLastRead();
    Get.back();
  }

  Future<DetailSurah> getAllDetailSurah(Map<String, dynamic> surah) async {
    int? numberOfSurah = surah['numberOfSurah'];
    int? indexVersesOnSurah = surah['indexVersesOnSurah'];

    // With Json FIle
    String jsonString = await rootBundle.loadString(
      'assets/surah/$numberOfSurah.json',
    );
    Map<String, dynamic> data = json.decode(jsonString);
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
      'assets/surah/all.json',
    );
    List data = json.decode(jsonString);

    if (data.isEmpty) {
      return [];
    }
    List<Surah> surahList = data.map((e) => Surah.fromJson(e)).toList();
    return surahList.reversed.toList();
  }

  void playAudio(int index) async {
    if (await internetCheck()) {
      await player.setUrl('${EndPoint.audio}/${convertIndexString(index)}.mp3');
      await player.play();
    } else {
      snackbarMessage(
        'No Internet Connection',
        'Hubungkan dengan Akses Internet',
      );
    }
    isPlayAudio.value = false;
  }

  void stopAudio() async {
    await player.stop();
  }

  set tabIndex(int value) {
    tabController.animateTo(value);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 114, vsync: this);
    tabIndex = 114 - numberOfSurah;
    currentIndexTab.value = numberOfSurah;
  }

  @override
  void onClose() async {
    stopAudio();
    super.onClose();
  }
}
