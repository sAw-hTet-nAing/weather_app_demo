import 'package:flutter/material.dart';
import 'package:weather_app/app_widget/rectangular_cart_widget.dart';
import 'package:weather_app/models/forecast_weather_model.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';
import 'package:weather_app/utils/utils.dart';

Widget forecastWeatherWidget({required FocastWeatherModel forecastWeather}) {
  return SizedBox(
    height: Dimesion.screenHeight * 0.5,
    child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: forecastWeather.forecast!.forecastday!.length,
        itemBuilder: (_, index) => RectangleCard(
            color: AppColor.topGr,
            vert: Dimesion.width5,
            widget: Container(
              padding: EdgeInsets.all(Dimesion.width10),
              child: Row(children: [
                if (forecastWeather.forecast!.forecastday![index].date!.day ==
                    DateTime.now().day)
                  SizedBox(
                    width: Dimesion.screenWidth * 0.23,
                    child: Text(
                      "Today",
                      style: MyTextStyle.normalText,
                    ),
                  )
                else if (forecastWeather
                        .forecast!.forecastday![index].date!.day ==
                    DateTime.now().day - 1)
                  SizedBox(
                    width: Dimesion.screenWidth * 0.23,
                    child: Text(
                      "YesterDay",
                      style: MyTextStyle.normalText,
                    ),
                  )
                else
                  SizedBox(
                    width: Dimesion.screenWidth * 0.23,
                    child: Text(
                      Utils.dateFormat.format(
                          forecastWeather.forecast!.forecastday![index].date!),
                      style: MyTextStyle.normalText,
                    ),
                  ),
                SizedBox(
                    height: Dimesion.height20,
                    width: Dimesion.height20,
                    child: Image.network(
                        "https:${forecastWeather.forecast!.forecastday![index].day!.condition!.icon!}")),
                SizedBox(
                  width: Dimesion.width10,
                ),
                Text(
                  "${forecastWeather.forecast!.forecastday![index].day!.mintempC} \u2103",
                  style: MyTextStyle.normalText,
                ),
                SizedBox(
                  width: Dimesion.width5,
                ),
                SizedBox(
                  width: Dimesion.width30 * 1.7,
                  child: LinearProgressIndicator(
                    value: 1.0,
                    color: Colors.amber,
                    backgroundColor: Colors.amber[900],
                  ),
                ),
                SizedBox(
                  width: Dimesion.width5,
                ),
                Text(
                  "${forecastWeather.forecast!.forecastday![index].day!.maxtempC} \u2103",
                  style: MyTextStyle.normalText,
                ),
              ]),
            ))),
  );
}
