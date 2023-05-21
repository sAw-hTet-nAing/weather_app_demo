// ignore_for_file: iterable_contains_unrelated_type

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/app_widget/app_back_widget.dart';
import 'package:weather_app/app_widget/app_loading_widget.dart';
import 'package:weather_app/app_widget/rectangular_cart_widget.dart';
import 'package:weather_app/screens/search_screen/search_controller.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController _searchController = Get.find<SearchController>();
  @override
  void initState() {
    _searchController.searchTextController.clear();
    _searchController.isLoading.value = false;
    _searchController.searchResults.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        builder: (controller) => Container(
              decoration: const BoxDecoration(gradient: AppColor.backGroundGr),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: backButton(context),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "Search",
                    style: MyTextStyle.heading,
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                  child: Column(children: [
                    SizedBox(
                      height: Dimesion.height20,
                    ),
                    searchTextField(
                        textEditingController: controller.searchTextController,
                        onChange: (val) {
                          EasyDebounce.debounce(
                              "search", const Duration(milliseconds: 300), () {
                            controller.getsearch(query: val);
                          });
                        }),
                    SizedBox(
                      height: Dimesion.height10,
                    ),
                    controller.isLoading.value
                        ? Column(
                            children: [
                              SizedBox(
                                height: Dimesion.screenHeight * 0.3,
                              ),
                              appLoadingWidget()
                            ],
                          )
                        : controller.searchResults.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: Dimesion.screenHeight * 0.3,
                                  ),
                                  Text(
                                    "No results",
                                    style: MyTextStyle.labelText,
                                  )
                                ],
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.searchResults.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => RectangleCard(
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
                                            SizedBox(
                                              width: Dimesion.screenWidth * 0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .searchResults[index]
                                                        .name!,
                                                    style:
                                                        MyTextStyle.normalText,
                                                  ),
                                                  SizedBox(
                                                    height: Dimesion.width5 / 2,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      "(${controller.searchResults[index].country!})",
                                                      style: MyTextStyle
                                                          .normalTextGrey,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  if (controller
                                                      .homeController.favList
                                                      .contains(controller
                                                          .searchResults[index]
                                                          .name)) {
                                                    setState(() {
                                                      controller.homeController
                                                          .isFav.value = false;
                                                    });
                                                    await controller
                                                        .setDefaultLocation(
                                                            lat: controller
                                                                .searchResults[
                                                                    index]
                                                                .lat
                                                                .toString(),
                                                            long: controller
                                                                .searchResults[
                                                                    index]
                                                                .lon
                                                                .toString());
                                                  } else {
                                                    await controller
                                                        .setDefaultLocation(
                                                            lat: controller
                                                                .searchResults[
                                                                    index]
                                                                .lat
                                                                .toString(),
                                                            long: controller
                                                                .searchResults[
                                                                    index]
                                                                .lon
                                                                .toString());
                                                  }
                                                },
                                                child: Text(
                                                  "Set Default Location",
                                                  style: MyTextStyle.smallText
                                                      .copyWith(
                                                          color: AppColor
                                                              .activeGreen),
                                                ))
                                          ],
                                        ))))
                  ]),
                ),
              ),
            ));
  }

  Widget searchTextField(
      {required TextEditingController textEditingController,
      required onChange}) {
    return RectangleCard(
        width: 0.0,
        radius: Dimesion.radius15 / 2,
        widget: TextFormField(
          autofocus: true,
          autocorrect: false,
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColor.topGr,
              size: Dimesion.iconSize16,
            ),
            hintText: "Search city here",
            hintStyle: MyTextStyle.booktittleTextGrey,
          ),
          onChanged: onChange,
        ));
  }
}
