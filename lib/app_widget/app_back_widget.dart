import 'package:flutter/material.dart';

import 'package:weather_app/utils/dimesion.dart';

Widget backButton(BuildContext context) {
  return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
        size: Dimesion.iconSize16,
      ));
}
