import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/search_model.dart';
import 'package:weather_app/routes/route_helper.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';
import 'package:weather_app/screens/search_screen/search_repo.dart';
import 'package:weather_app/services/share_data_services.dart';
import 'package:weather_app/utils/app_color.dart';

class SearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  final HomeController homeController;

  SearchController({required this.searchRepo, required this.homeController});
  RxBool isLoading = false.obs;
  RxList<SearchModel> searchResults = <SearchModel>[].obs;
  final TextEditingController searchTextController = TextEditingController();
  Future<void> getsearch({required String query}) async {
    isLoading.value = true;
    searchResults.clear;
    update();
    try {
      Response response = await searchRepo.search(q: query);
      if (response.statusCode == 200) {
        searchResults.assignAll(searchRepo.parseResponse(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading.value = false;
    update();
  }

  Future<void> setDefaultLocation(
      {required String lat, required String long}) async {
    isLoading.value = true;
    update();
    try {
      await homeController.getCurrentWeather(lat: lat, long: long);
      await homeController.getForecastWeather(lat: lat, long: long);
    } catch (e) {
      debugPrint(e.toString());
    }
    await AppShareData.setDefaultLat(lat);
    await AppShareData.setDefaultlong(long);
    for (var element in homeController.favList) {
      if (element.city == homeController.currentWeather.value.location!.name) {
        homeController.isFav.value = true;
        update();
      } else {
        homeController.isFav.value = false;
        update();
      }
    }
    Get.snackbar("Success", "Your Default Location Has Changed.",
        backgroundColor: AppColor.topGr, colorText: Colors.white);
    await Get.offNamed(RouteHelper.initial);
    isLoading.value = false;
    update();
  }
}
