import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

Widget percentWidget({required int value, required String title}) {
  return SizedBox(
    width: Dimesion.width30 * 2,
    child: Column(
      children: [
        CircularPercentIndicator(
          progressColor: AppColor.activeGreen,
          center: Text(
            "$value%",
            style: MyTextStyle.smallText,
          ),
          percent: double.parse((value / 100).toString()),
          lineWidth: 4,
          radius: Dimesion.radius20 * 0.8,
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
        Text(
          title,
          style: MyTextStyle.normalTextGrey,
        )
      ],
    ),
  );
}
