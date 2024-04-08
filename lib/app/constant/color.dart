import 'package:flutter/material.dart';

const appBlack = Color(0xff494F56);

const appWhite = Colors.white;
const appBlueLight1 = Color(0xff488295);
const appBlueLight2 = Color(0xffE3F5F6);
const appBlueLight3 = Color(0xffE3F5F6);
const appGrey = Color(0xffA2A9B3);
const appPurple = Color(0xff80659C);

// Light Theme
ThemeData appLight = ThemeData(
  primaryColor: appBlack,
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: appWhite,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: appBlack,
    ),
  ),
  iconTheme: const IconThemeData(color: appBlueLight2),
  appBarTheme: const AppBarTheme(
    backgroundColor: appWhite,
    // titleTextStyle: TextStyle(
    //   color: appPurple,
    //   fontSize: 20,
    //   fontWeight: FontWeight.bold,
    // ),
    iconTheme: IconThemeData(
      color: appGrey,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: appWhite,
  ),
);
