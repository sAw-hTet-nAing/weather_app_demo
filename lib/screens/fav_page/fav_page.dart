import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app_widget/app_back_widget.dart';
import 'package:weather_app/app_widget/app_loading_widget.dart';
import 'package:weather_app/app_widget/rectangular_cart_widget.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Container(
            decoration: const BoxDecoration(gradient: AppColor.backGroundGr),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Your's Favourites",
                  style: MyTextStyle.heading,
                ),
                leading: backButton(context),
              ),
              backgroundColor: Colors.transparent,
              body: controller.isLoading.value
                  ? appLoadingWidget()
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimesion.width10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.favList.length,
                      itemBuilder: (contex, index) => RectangleCard(
                          vert: Dimesion.width5,
                          width: 0.0,
                          radius: Dimesion.radius15 / 2,
                          color: AppColor.topGr,
                          widget: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimesion.width10,
                                  vertical: Dimesion.width10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => controller.tapFavtoDetail(
                                        lat: controller.favList[index].lat!,
                                        long: controller.favList[index].long),
                                    child: SizedBox(
                                      width: Dimesion.screenWidth * 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.favList[index].city!,
                                            style: MyTextStyle.normalText,
                                          ),
                                          SizedBox(
                                            height: Dimesion.width5 / 2,
                                          ),
                                          SizedBox(
                                            child: Text(
                                              "(${controller.favList[index].country!})",
                                              style: MyTextStyle.normalTextGrey,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => controller.delete(
                                          city:
                                              controller.favList[index].city!),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: Dimesion.iconSize16,
                                      ))
                                ],
                              )))),
            )));
  }
}
