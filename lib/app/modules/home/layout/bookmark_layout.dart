import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/size_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class BookmarkLayout extends GetView<HomeController> {
  const BookmarkLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return GetBuilder<HomeController>(
      builder: (controller) {
        return FutureBuilder(
          future: controller.getAllBookmark(),
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

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: sizeConfig.getProportionateScreenHeight(20),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data![index];
                  return InkWell(
                    // Goto Index Ayat
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                        'numberOfSurah': data['numberOfSurah'],
                        'indexVersesOnSurah': data['indexVersesOnSurah'],
                      });
                    },
                    onLongPress: () {
                      // Dialog delete bookmark
                      Get.dialog(AlertDialog(
                        title: const Text(
                          'Hapus Bookmark ? ',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        titlePadding: EdgeInsets.only(
                          top: sizeConfig.getProportionateScreenHeight(20),
                          right: sizeConfig.getProportionateScreenWidth(20),
                          left: sizeConfig.getProportionateScreenWidth(20),
                          bottom: sizeConfig.getProportionateScreenHeight(40),
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              'BATAL',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: sizeConfig.getProportionateScreenWidth(5)),
                          InkWell(
                            onTap: () {
                              controller.deleteBookmark(data['id']);
                              Get.back();
                            },
                            child: Text(
                              'HAPUS',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bookmark_add,
                            color: Colors.brown,
                          ),
                          SizedBox(
                            width: sizeConfig.getProportionateScreenWidth(10),
                          ),
                          Text(
                            'QS. ${data['nameOfSurah']} : Ayat ${data['numberOfVerses']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.all(
                              sizeConfig.getProportionateScreenWidth(2.5),
                            ),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
