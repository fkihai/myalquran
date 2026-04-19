import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:quran/quran.dart' as quran;

import '../../../core/constant/color.dart';

class SurahWidget extends StatelessWidget {
  final List<Surah> surahList;
  const SurahWidget({super.key, required this.surahList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: surahList.length,
        itemBuilder: (context, index) {
          final surah = surahList[index];

          return ListTile(
            leading: Text(
              quran.getVerseEndSymbol(index + 1),
              style: const TextStyle(
                color: appBlueLight1,
                fontSize: 27,
              ),
            ),
            title: Text(
              surah.nameLatin,
              style: const TextStyle(
                color: appBlueLight1,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                '${surah.totalVerses} ayat | ${surah.revalationPlace}',
                style: const TextStyle(
                  color: appGrey,
                  fontSize: 14,
                ),
              ),
            ),
            trailing: Text(
              surah.name,
              style: const TextStyle(
                fontFamily: 'Lpmq',
                color: appBlueLight1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          );
        });
  }
}
