import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../data/model/surah.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class SurahLayout extends GetView<HomeController> {
  const SurahLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
                  leading: Container(
                    height: 70,
                    width: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/list.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${surah.nomor}',
                        style: const TextStyle(
                          color: appBlack,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '${surah.namaLatin}',
                    style: const TextStyle(
                      color: appBlack,
                    ),
                  ),
                  subtitle: Text(
                    '${surah.jumlahAyat} ayat | ${surah.tempatTurun}',
                    style: const TextStyle(
                      color: appBlueLight1,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Text(
                    '${surah.nama}',
                    style: const TextStyle(
                      fontFamily: 'Lpmq',
                      color: appBlack,
                      fontSize: 20,
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
