import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import 'package:weather_app/app_widget/app_loading_widget.dart';
import 'package:weather_app/routes/route_helper.dart';
import 'package:weather_app/screens/drawer_screen/drawer_page.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';
import 'package:weather_app/screens/home_screen/home_widgets/current_weather_widget.dart';
import 'package:weather_app/screens/home_screen/home_widgets/forecast_title_widget.dart';
import 'package:weather_app/screens/home_screen/home_widgets/forecast_weather_widget.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Container(
            decoration: const BoxDecoration(gradient: AppColor.backGroundGr),
            child: controller.hasPermision.value
                ? ZoomDrawer(
                    controller: controller.zoomDrawer,
                    shadowLayer1Color: Colors.transparent,
                    shadowLayer2Color: Colors.transparent,
                    style: DrawerStyle.defaultStyle,
                    showShadow: true,
                    mainScreenTapClose: true,
                    menuScreen: const MyDrawerPage(),
                    mainScreen: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text(
                          "Saw's Weather App",
                          style: MyTextStyle.heading,
                        ),
                        leading: IconButton(
                          icon: Icon(
                            CupertinoIcons.list_bullet_indent,
                            color: Colors.white,
                            size: Dimesion.iconSize16,
                          ),
                          onPressed: () => controller.toggleDrawer(),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.search,
                              color: Colors.white,
                              size: Dimesion.iconSize16,
                            ),
                            onPressed: () => Get.toNamed(RouteHelper.search),
                          ),
                        ],
                      ),
                      body: controller.isLoading.value
                          ? appLoadingWidget()
                          : SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimesion.width10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Dimesion.height20,
                                    ),
                                    Obx(
                                      () => currentWeatherWidget(
                                          cityName: controller.currentWeather
                                              .value.location!.name!,
                                          temp: controller.currentWeather.value
                                              .current!.tempC!,
                                          humidity: controller.currentWeather
                                              .value.current!.humidity,
                                          conditionText: controller
                                              .currentWeather
                                              .value
                                              .current!
                                              .condition!
                                              .text!,
                                          cloud: controller.currentWeather.value
                                              .current!.cloud,
                                          icon: controller.currentWeather.value
                                              .current!.condition!.icon!,
                                          onPress: () => controller.toggleFav(
                                              city: controller.currentWeather
                                                  .value.location!.name!,
                                              country: controller.currentWeather.value.location!.country!,
                                              lat: controller.currentWeather.value.location!.lat,
                                              long: controller.currentWeather.value.location!.lon,
                                              time: ""),
                                          isFav: controller.isFav.value),
                                    ),
                                    SizedBox(
                                      height: Dimesion.height40,
                                    ),
                                    forecastTitleWidget(),
                                    SizedBox(
                                      height: Dimesion.height10,
                                    ),
                                    Obx(() => forecastWeatherWidget(
                                        forecastWeather:
                                            controller.forecastWeather.value))
                                  ]),
                            ),
                    ),
                  )
                : Container(
                    decoration:
                        const BoxDecoration(gradient: AppColor.backGroundGr),
                  )));
  }
}
