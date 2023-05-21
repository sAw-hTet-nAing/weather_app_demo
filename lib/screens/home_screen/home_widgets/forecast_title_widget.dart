import 'package:flutter/material.dart';
import 'package:weather_app/app_widget/rectangular_cart_widget.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

Widget forecastTitleWidget() {
  return RectangleCard(
    color: AppColor.topGr,
    width: 0.0,
    widget: Container(
      width: Dimesion.screenWidth * 0.45,
      padding: EdgeInsets.all(Dimesion.width5),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_rounded,
            color: Colors.white,
            size: Dimesion.iconSize16,
          ),
          SizedBox(
            width: Dimesion.width10,
          ),
          Text(
            "WEEK FORECAST",
            style: MyTextStyle.normalText,
          )
        ],
      ),
    ),
  );
}
