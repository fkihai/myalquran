import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';
import '../../constant/size_config.dart';
import '../../data/model/surah.dart';
import '../detail_surah/controllers/detail_surah_controller.dart';

class SurahTitle extends StatelessWidget {
  SurahTitle({super.key, required this.surah});
  final Surah surah;
  final DetailSurahController controller = DetailSurahController();

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizeConfig.getProportionateScreenWidth(10),
        vertical: sizeConfig.getProportionateScreenHeight(10),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.blue.shade300,
        title: Text(
          '${surah.namaLatin}',
          style: const TextStyle(
            color: appWhite,
          ),
        ),
        subtitle: Text(
          '${surah.nomor} Ayat | ${surah.tempatTurun}',
          style: const TextStyle(
            color: appWhite,
          ),
        ),
        trailing: Text(
          '${surah.nama}',
          style: const TextStyle(
            fontFamily: 'Lpmq',
            fontSize: 30,
            color: appWhite,
          ),
        ),
        //   trailing: Obx(
        //     () => IconButton(
        //       icon: controller.isPlayAudio.value
        //           ? const Icon(Icons.stop)
        //           : const Icon(Icons.play_arrow),
        //       iconSize: 30,
        //       color: Colors.white,
        //       onPressed: () {
        //         controller.isPlayAudio.value = !controller.isPlayAudio.value;
        //         controller.isPlayAudio.value
        //             ? controller.playAudio('${surah.audio}')
        //             : controller.stopAudio();
        //       },
        //     ),
        //   ),
      ),
    );
  }
}
