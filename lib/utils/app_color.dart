import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Colors.amber;
  static const Color secondBackColor = Color(0xff30144c);
  static const Color mainTextColor = Colors.white;
  static const Color buttonColor = Color(0xffca572f);
  static const Color logoColor = Color.fromARGB(255, 84, 48, 48);
  static const Color activeGreen = Color.fromARGB(255, 43, 255, 135);
  static const Color widgetGreen = Color.fromARGB(255, 21, 136, 71);
  static const Color topGr = Color.fromARGB(255, 27, 48, 48);
  static const Color bottomColor = Color.fromARGB(
    255,
    10,
    18,
    20,
  );
  static const Color botGr = Color.fromARGB(
    200,
    13,
    23,
    25,
  );
  static const LinearGradient backGroundGr = LinearGradient(
      colors: [topGr, botGr],
      begin: Alignment.topCenter,
      tileMode: TileMode.decal,
      end: Alignment.bottomCenter);
}
