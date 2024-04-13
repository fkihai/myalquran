import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quran/quran.dart' as quran;

import '../../../constant/color.dart';
import '../../../constant/size_config.dart';
import '../../../data/model/surah.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class SurahLayout extends GetView<HomeController> {
  const SurahLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return FutureBuilder<List<Surah>>(
      future: controller.getAllSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak Ada Data'),
          );
        }

        return Obx(
          () => ListView.builder(
            itemCount: controller.foundSurah.length,
            itemBuilder: (context, index) {
              Surah surah = controller.foundSurah[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                    'numberOfSurah': surah.nomor,
                    'indexVersesOnSurah': null,
                  });
                },
                child: ListTile(
                  leading: Text(
                    quran.getVerseEndSymbol(surah.nomor!.toInt()),
                    style: const TextStyle(
                      color: appBlueLight1,
                      fontSize: 27,
                    ),
                  ),
                  title: Text(
                    '${surah.namaLatin}',
                    style: const TextStyle(
                      color: appBlueLight1,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${surah.jumlahAyat} ayat | ${surah.tempatTurun}',
                      style: const TextStyle(
                        color: appGrey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  trailing: Text(
                    '${surah.nama}',
                    style: const TextStyle(
                      fontFamily: 'Lpmq',
                      color: appBlueLight1,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
