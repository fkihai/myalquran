import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/color.dart';
import '../../../domain/entities/surah.dart';

class SurahTitle extends StatelessWidget {
  const SurahTitle({super.key, this.surah});
  final Surah? surah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.blue.shade300,
        title: Text(
          surah!.nameLatin,
          style: const TextStyle(
            color: appWhite,
          ),
        ),
        subtitle: Text(
          '${surah!.number} Ayat | ${surah!.revelationType}',
          style: const TextStyle(
            color: appWhite,
          ),
        ),
        trailing: Text(
          surah!.nameLatin,
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
        //             ? controller.playAudio('${surah!.audio}')
        //             : controller.stopAudio();
        //       },
        //     ),
        //   ),
      ),
    );
  }
}
