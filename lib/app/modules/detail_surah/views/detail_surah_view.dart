import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalquran/app/constant/color.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../constant/size_config.dart';
import '../../../data/model/surah.dart';
import '../../widget/ayat.dart';
import '../../widget/basmalah.dart';
import '../../widget/surah_title.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final Map<String, dynamic> surahArgument = Get.arguments;
  late int numberOfSurah = surahArgument['numberOfSurah'];

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);

    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: sizeConfig.getProportionateScreenWidth(180),
            height: sizeConfig.getProportionateScreenHeight(70),
            child: Image.asset(
              'assets/img/logo-appbar.png',
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getListSurah(),
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

            List<Surah> listSurah = snapshot.data as List<Surah>;

            return DefaultTabController(
              length: listSurah.length,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar.secondary(
                      isScrollable: true,
                      controller: controller.tabController,
                      onTap: (value) {
                        controller.currentIndexTab.value = 114 - value;
                      },
                      tabs: listSurah
                          .map(
                            (Surah tab) => Tab(
                              child: SizedBox(
                                height:
                                    sizeConfig.getProportionateScreenHeight(30),
                                child: Center(
                                  child: Text(
                                    '${tab.namaLatin}',
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.tabController,
                      children: listSurah
                          .map(
                            (Surah view) => Column(
                              children: [
                                Expanded(
                                  child: FutureBuilder(
                                    future: controller.getAllDetailSurah({
                                      'numberOfSurah': view.nomor,
                                      'indexVersesOnSurah':
                                          surahArgument['indexVersesOnSurah'],
                                    }),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: appBlueLight1,
                                          ),
                                        );
                                      }
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: Text('Tidak Ada Data'),
                                        );
                                      }

                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        controller:
                                            controller.autoScrollController,
                                        itemCount: snapshot.data!.ayat!.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              index == 0
                                                  ? Column(
                                                      children: [
                                                        SurahTitle(surah: view),
                                                        BasmalahVerses(
                                                          nomor: view.nomor!
                                                              .toInt(),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              AutoScrollTag(
                                                key: ValueKey(index),
                                                controller: controller
                                                    .autoScrollController,
                                                index: index,
                                                child: VersesView(
                                                  ayat: snapshot
                                                      .data!.ayat![index],
                                                  detailSurah: snapshot.data!,
                                                  index: index,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Obx(
                    () => Container(
                      width: sizeConfig.getScreenWidth(),
                      height: sizeConfig.getProportionateScreenHeight(75),
                      padding: EdgeInsets.all(
                        sizeConfig.getProportionateScreenWidth(10),
                      ),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                        )
                      ]),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Putar Surah',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${listSurah[114 - controller.currentIndexTab.value].namaLatin}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              controller.isPlayAudio.value =
                                  !controller.isPlayAudio.value;
                              controller.isPlayAudio.value
                                  ? controller.playAudio(
                                      controller.currentIndexTab.value)
                                  : controller.stopAudio();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    controller.isPlayAudio.value
                                        ? Icons.stop
                                        : Icons.play_arrow,
                                    color: Colors.green.shade200,
                                  ),
                                  const Text('Putar'),
                                  SizedBox(
                                    width: sizeConfig
                                        .getProportionateScreenWidth(5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: sizeConfig.getProportionateScreenWidth(10),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
