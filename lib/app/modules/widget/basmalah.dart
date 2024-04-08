import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../constant/size_config.dart';

class BasmalahVerses extends StatelessWidget {
  const BasmalahVerses({super.key, required this.nomor});
  final int nomor;

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig(context);
    if (nomor != 1 && nomor != 9) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: sizeConfig.getProportionateScreenHeight(10),
              bottom: sizeConfig.getProportionateScreenHeight(20),
            ),
            child: const Text(
              'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
              style: TextStyle(
                fontFamily: 'Lpmq',
                fontWeight: FontWeight.bold,
                color: appBlack,
                fontSize: 25,
              ),
            ),
          ),
          const Divider(
            thickness: 0.6,
            color: appBlack,
          ),
        ],
      );
    }
    return Container();
  }
}
