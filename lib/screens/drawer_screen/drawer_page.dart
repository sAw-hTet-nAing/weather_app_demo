import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app_widget/app_back_widget.dart';
import 'package:weather_app/routes/route_helper.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class MyDrawerPage extends StatefulWidget {
  const MyDrawerPage({super.key});

  @override
  State<MyDrawerPage> createState() => _MyDrawerPageState();
}

class _MyDrawerPageState extends State<MyDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: backButton(context),
                elevation: 0,
              ),
              body: SafeArea(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                width: Dimesion.screenWidth,
                decoration: BoxDecoration(
                    gradient: AppColor.backGroundGr,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimesion.radius15),
                        topRight: Radius.circular(Dimesion.radius15))),
                child: Column(children: [
                  SizedBox(
                    height: Dimesion.screenHeight * 0.1,
                  ),
                  Text(
                    "Saw's Weather App",
                    style: MyTextStyle.heading,
                  ),
                  SizedBox(
                    height: Dimesion.height30,
                  ),
                  menuWidget(
                      title: "Favourite City",
                      icon: Icons.favorite_outline_rounded,
                      onPress: () => Get.toNamed(RouteHelper.fav)),
                  menuWidget(
                      title: "Send Notification",
                      icon: Icons.notification_add,
                      onPress: () => Get.toNamed(RouteHelper.noti))
                ]),
              )),
            ));
  }

  Widget menuWidget(
      {required String title, required IconData icon, required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        width: Dimesion.screenWidth,
        padding: EdgeInsets.all(Dimesion.width10),
        margin: EdgeInsets.only(bottom: Dimesion.height10),
        child: Row(children: [
          Icon(icon, color: Colors.white, size: Dimesion.iconSize16),
          SizedBox(
            width: Dimesion.width10,
          ),
          Text(
            title,
            style: MyTextStyle.normalText,
          )
        ]),
      ),
    );
  }
}
