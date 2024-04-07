import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';
import '../../constant/size_config.dart';
import '../home/controllers/home_controller.dart';

class SearchField extends GetView<HomeController> {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    TextEditingController controllerField = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.getProportionateScreenWidth(10),
          // vertical: sizeConfig.getProportionateScreenHeight(2),
        ),
        decoration: BoxDecoration(
          color: appBlueLight3.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    // vertical: sizeConfig.getProportionateScreenHeight(5),
                    horizontal: sizeConfig.getProportionateScreenWidth(8)),
                child: TextField(
                  controller: controllerField,
                  onChanged: (value) {
                    controller.filterSurah(value);
                  },
                  cursorColor: appBlueLight2,
                  decoration: const InputDecoration(
                    hintText: "Search surah...",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: appGrey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.search,
              size: 25.0,
            ),
            SizedBox(width: sizeConfig.getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
