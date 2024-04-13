import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myalquran/app/routes/app_pages.dart';

import '../../../constant/color.dart';
import '../../../constant/size_config.dart';
import '../../widget/search_field.dart';
import '../controllers/home_controller.dart';
import '../layout/bookmark_layout.dart';
import '../layout/surah_layout.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 180,
            height: 70,
            child: Image.asset(
              'assets/img/logo-appbar.png',
            ),
          ),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.getProportionateScreenWidth(0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizeConfig.getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: sizeConfig.getProportionateScreenHeight(10)),
                      const Text(
                        'Al Quran',
                        style: TextStyle(
                          fontSize: 14,
                          color: appGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Reading Surah",
                        style: TextStyle(
                          fontSize: 20,
                          color: appBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sizeConfig.getProportionateScreenHeight(10)),
                const SearchField(),
                SizedBox(height: sizeConfig.getProportionateScreenHeight(20)),
                TabBar.secondary(indicatorColor: appBlueLight1, tabs: [
                  Tab(
                    child: SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(30),
                      child: const Text(
                        'Surah',
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(30),
                      child: const Text(
                        'Bookmark',
                      ),
                    ),
                  ),
                ]),
                const Expanded(
                  child: TabBarView(
                    children: [
                      SurahLayout(),
                      BookmarkLayout(),
                    ],
                  ),
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                        'numberOfSurah':
                            controller.dataLastRead['numberOfSurah'],
                        'indexVersesOnSurah':
                            controller.dataLastRead['indexVersesOnSurah'],
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        dense: true,
                        leading: const Icon(Icons.book),
                        title: const Text('Lanjutkan Membaca'),
                        subtitle: Text(
                          "QS. ${controller.dataLastRead['nameOfSurah']}: Ayat ${controller.dataLastRead['numberOfVerses']}",
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
