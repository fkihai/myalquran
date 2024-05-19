import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';
import '../../constant/size_config.dart';
import '../../data/model/detail_surah.dart';
import '../detail_surah/controllers/detail_surah_controller.dart';

class ModalVerses extends DetailSurahController {
  Future show(
    BuildContext context,
    DetailSurah surah,
    Ayat ayat,
    int indexAyat,
    bool checkBookmark,
  ) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: Get.width,
          height: Get.height * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeConfig.getProportionateScreenHeight(5)),
              Center(
                child: Container(
                  width: sizeConfig.getProportionateScreenWidth(100),
                  height: sizeConfig.getProportionateScreenHeight(7),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: sizeConfig.getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: sizeConfig.getProportionateScreenHeight(5),
                  horizontal: sizeConfig.getProportionateScreenWidth(20),
                ),
                child: Text('QS. ${surah.namaLatin}: Ayat ${ayat.nomor}'),
              ),
              TileFeature(
                icon: Icons.book,
                title: 'Tandai Terakhir Membaca',
                action: () {
                  addBookmark(true, surah, ayat, indexAyat);
                },
                disable: false,
              ),
              TileFeature(
                icon: Icons.bookmark_add,
                title:
                    checkBookmark ? "Sudah Terbookmark" : 'Simpan Ke Bookmark',
                action: checkBookmark
                    ? () {}
                    : () {
                        addBookmark(false, surah, ayat, indexAyat);
                      },
                disable: checkBookmark,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TileFeature extends StatelessWidget {
  const TileFeature(
      {super.key,
      required this.title,
      required this.icon,
      this.action,
      this.disable});
  final String title;
  final IconData icon;
  final bool? disable;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    return InkWell(
      onTap: action ?? () {},
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: disable == true ? appGrey : appBlueLight1,
              size: sizeConfig.getProportionateScreenWidth(30),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: disable == true ? appGrey : appBlack,
              ),
            ),
          ),
          Divider(
            thickness: 0.6,
            indent: sizeConfig.getProportionateScreenWidth(20),
            endIndent: sizeConfig.getProportionateScreenWidth(20),
          ),
        ],
      ),
    );
  }
}
