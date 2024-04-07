import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double textScaleFactor = 0.0;
  static Orientation? orientation;
  static double? defaultSize = 0.0;

  SizeConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    // textScaleFactor = _mediaQueryData.textScaleFactor;
  }
  double getScreenWidth() {
    double screenWidth = SizeConfig.screenWidth;
    return screenWidth;
  }

  double getScreenHeight() {
    double screenHeight = SizeConfig.screenHeight;
    return screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }
}
