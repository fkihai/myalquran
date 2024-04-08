import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.dark_mode),
          //   ),
          //   SizedBox(width: sizeConfig.getProportionateScreenWidth(10))
          // ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.getProportionateScreenWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                ))
              ],
            ),
          ),
        ));
  }
}
