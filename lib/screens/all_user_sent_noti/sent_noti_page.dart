import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app_widget/app_back_widget.dart';

import 'package:weather_app/screens/all_user_sent_noti/noti_controller.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class SentNotiPage extends StatefulWidget {
  const SentNotiPage({super.key});

  @override
  State<SentNotiPage> createState() => _SentNotiPageState();
}

class _SentNotiPageState extends State<SentNotiPage> {
  final NotiController _notiController = Get.find<NotiController>();
  @override
  void initState() {
    _notiController.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotiController>(
        builder: (controller) => Container(
              decoration: const BoxDecoration(gradient: AppColor.backGroundGr),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: backButton(context),
                  title: Text(
                    "Sent Users to Noti",
                    style: MyTextStyle.heading,
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(Dimesion.width10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimesion.height10,
                        ),
                        Text(
                          "Sent notification to total using devices.",
                          style: MyTextStyle.normalText,
                        ),
                        Text(
                          "Total Using Devices :  (${controller.allUser.length})",
                          style: MyTextStyle.normalText,
                        ),
                        SizedBox(
                          height: Dimesion.height20,
                        ),
                        normaTextField(
                            controller: controller.titleController,
                            label: "Noti Title",
                            hint: "Enter your noti title"),
                        SizedBox(
                          height: Dimesion.height20,
                        ),
                        normaTextField(
                            controller: controller.bodyController,
                            label: "Noti Message",
                            hint: "Enter your noti message"),
                        SizedBox(
                          height: Dimesion.height20,
                        ),
                        Center(
                          child: Container(
                            width: Dimesion.screenWidth * 0.8,
                            decoration: BoxDecoration(
                                color: AppColor.topGr,
                                borderRadius: BorderRadius.circular(
                                    Dimesion.radius15 / 2)),
                            child: TextButton(
                              child: const Text(
                                "Sent Notification",
                                style: TextStyle(color: AppColor.activeGreen),
                              ),
                              onPressed: () {
                                controller.sentNoti();
                              },
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ));
  }

  Widget normaTextField(
      {required TextEditingController controller,
      required String label,
      required String hint}) {
    return TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
            labelText: label,
            labelStyle: MyTextStyle.priceText,
            hintText: hint,
            hintStyle: MyTextStyle.normalTextGrey));
  }
}
