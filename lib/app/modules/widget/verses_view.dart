import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalquran/app/constant/color.dart';
import 'package:myalquran/app/modules/widget/modal_verses.dart';
import 'package:quran/quran.dart' as quran;

// import '../../constant/color.dart';
import '../../constant/size_config.dart';
import '../../data/model/detail_surah.dart';
import '../detail_surah/controllers/detail_surah_controller.dart';

class VersesView extends GetView<DetailSurahController> {
  const VersesView({
    super.key,
    required this.ayat,
    required this.detailSurah,
    required this.index,
  });
  final Ayat ayat;
  final DetailSurah detailSurah;
  final int index;
  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return Padding(
      padding: EdgeInsets.only(
        top: sizeConfig.getProportionateScreenHeight(10),
        bottom: sizeConfig.getProportionateScreenHeight(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                color: appBlack,
                onPressed: () async {
                  final bool checkBookmark = await controller.checkBookmark(
                    numberOfSurah: detailSurah.nomor!.toInt(),
                    numberOfVerses: ayat.nomor!.toInt(),
                  );

                  log("bokmark: $checkBookmark");

                  ModalVerses modalVerses = ModalVerses();
                  modalVerses.show(
                    context,
                    detailSurah,
                    ayat,
                    index,
                    checkBookmark,
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: sizeConfig.getProportionateScreenWidth(20),
                    left: sizeConfig.getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: '${ayat.ar} ',
                                style: const TextStyle(
                                  fontFamily: 'Lpmq',
                                  color: appBlueLight1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 1.0,
                                  height: 2.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: quran.getVerseEndSymbol(
                                      ayat.nomor!.toInt(),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Lpmq',
                                      color: appBlueLight1,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0,
                                      height: 2.3,
                                    ),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: sizeConfig.getProportionateScreenHeight(20)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${ayat.tr}",
                              style: const TextStyle(
                                  fontSize: 13, color: appBlueLight1),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: sizeConfig.getProportionateScreenHeight(10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${ayat.idn}",
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Divider(
            thickness: 0.6,
            color: appBlack,
          )
        ],
      ),
    );
  }
}
