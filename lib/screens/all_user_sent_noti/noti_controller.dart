import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/screens/all_user_sent_noti/noti_repo.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';

class NotiController extends GetxController implements GetxService {
  final NotiRepo notiRepo;
  final HomeController homeController;
  NotiController({required this.notiRepo, required this.homeController});
  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  RxList allUser = [].obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  Future<void> getAllUsers() async {
    allUser.assignAll(homeController.allUser);

    update();
  }

  Future<void> sentNoti() async {
    isLoading.value = true;
    update();

    for (var element in allUser) {
      await notiRepo.sentNoti(
          body: bodyController.text,
          title: titleController.text,
          fcm: element["fcm_tokens"]);
    }

    BotToast.showText(text: "Sent");
    isLoading.value = false;
    update();
  }
}
