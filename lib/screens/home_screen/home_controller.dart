// ignore_for_file: iterable_contains_unrelated_type, unnecessary_new, unused_element, body_might_complete_normally_nullable

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/db_model.dart';
import 'package:weather_app/models/forecast_weather_model.dart';
import 'package:weather_app/routes/route_helper.dart';

import 'package:weather_app/screens/home_screen/home_repo.dart';
import 'package:weather_app/services/db_services.dart';
import 'package:weather_app/services/share_data_services.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  @override
  void onInit() {
    getFav();
    getWeatherData();
    addUserToFireStore();

    super.onInit();
  }

  final CollectionReference users =
      FirebaseFirestore.instance.collection('fcm_keys');
  RxBool isLoading = false.obs;

  Rx<CurrentWeatherModel> currentWeather = CurrentWeatherModel().obs;
  Rx<FocastWeatherModel> forecastWeather = FocastWeatherModel().obs;

  RxBool hasPermision = false.obs;
  RxString defaultLat = "".obs;
  RxString defaultLong = "".obs;
  initializeDefaultLocation() async {
    defaultLat.value = await AppShareData.getDefaultlat();
    defaultLong.value = await AppShareData.getDefaultlong();
    hasPermision.value = await AppShareData.getPermission();

    update();
  }

  Future<void> getWeatherData() async {
    hasPermision.value = await handleLocationPermission();
    await AppShareData.setPermission(hasPermision.value);
    update();
    initializeDefaultLocation();
    isLoading.value = true;
    update();

    defaultLat.value = await AppShareData.getDefaultlat();
    defaultLong.value = await AppShareData.getDefaultlong();

    if (defaultLat.value == "" || defaultLong.value == "") {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      defaultLat.value = position.latitude.toString();
      defaultLong.value = position.longitude.toString();
      update();
    }

    if (hasPermision.value == true) {
      await getCurrentWeather(
        lat: defaultLat.value,
        long: defaultLong.value,
      );
      await getForecastWeather(lat: defaultLat.value, long: defaultLong.value);
    } else {}
    for (var element in favList) {
      if (element.city == currentWeather.value.location!.name) {
        isFav.value = true;
        update();
      } else {
        isFav.value = false;
        update();
      }
    }
    isLoading.value = false;
    update();
  }

  Future<void> tapFavtoDetail(
      {required String lat, required String long}) async {
    isLoading.value = true;
    update();
    try {
      await getCurrentWeather(lat: lat, long: long);
      await getForecastWeather(lat: lat, long: long);
    } catch (e) {
      debugPrint(e.toString());
    }
    await AppShareData.setDefaultLat(lat);
    await AppShareData.setDefaultlong(long);
    for (var element in favList) {
      if (element.city == currentWeather.value.location!.name) {
        isFav.value = true;
        update();
      } else {
        isFav.value = false;
        update();
      }
      isLoading.value = false;
      update();
    }

    await Get.offNamed(RouteHelper.initial);
    isLoading.value = false;
    update();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> getCurrentWeather(
      {required String lat, required String long}) async {
    try {
      Response response = await homeRepo.getCurrentWeather(q: "$lat, $long");
      if (response.statusCode == 200) {
        currentWeather.value = CurrentWeatherModel.fromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getForecastWeather(
      {required String lat, required String long}) async {
    try {
      Response response = await homeRepo.getForecastWeather(q: "$lat, $long");
      if (response.statusCode == 200) {
        forecastWeather.value = FocastWeatherModel.fromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //*For Drawer =================================>
  final zoomDrawer = ZoomDrawerController();
  void toggleDrawer() {
    zoomDrawer.toggle?.call();
    update();
  }

  //*For Fav=================================>
  Future<void> addFav({DB? fav}) async {
    await DBService.insert(fav);
  }

  addTaskToDB({
    required String city,
    required String country,
    required dynamic lat,
    required dynamic long,
    required String time,
  }) async {
    await addFav(
        fav: DB(
      city: city,
      country: country,
      lat: lat,
      long: long,
      time: time,
    ));
  }

  Future<void> delete({required String city}) async {
    await DBService.delete(city);
    await getFav();

    if (favList.isEmpty) {
      isFav.value = false;
    } else {
      if (currentWeather.value.location!.name == city) {
        isFav.value = false;

        update();
      } else {
        isFav.value = true;
        update();
      }
    }

    update();
  }

  List<DB> favList = <DB>[];
  Future<void> getFav() async {
    List<Map<String, dynamic>> fav = await DBService.query();

    favList.assignAll(fav.map((data) => new DB.fromJson(data)).toList());

    update();
  }

  Future<void> isExist() async {}
  RxBool isFav = false.obs;
  Future<void> toggleFav({
    required String city,
    required String country,
    required dynamic lat,
    required dynamic long,
    required String time,
  }) async {
    List isExist = await DBService.check(city);

    if (isExist.isEmpty) {
      addTaskToDB(
          city: city, country: country, lat: lat, long: long, time: time);
      isFav.value = true;

      await getFav();
      BotToast.showText(text: "Added to Favourite");
    } else {
      for (var element in isExist) {
        if (element["city"] == city) {
          delete(city: city);
          isFav.value = !isFav.value;
          await getFav();
          BotToast.showText(text: "Remove From Favourite");
          update();
        } else {
          addTaskToDB(
              city: city, country: country, lat: lat, long: long, time: time);
          isFav.value = !isFav.value;

          await getFav();
          BotToast.showText(text: "Added to Favourite");
          update();
        }
      }
    }

    update();
  }

  Future<bool?> _checkDevice(fcm) async {
    bool isExist = false;
    for (var element in allUser) {
      if (element["fcm_tokens"] == fcm) {
        isExist = true;
        update();
      } else {
        isExist = false;
        update();
      }
      return isExist;
    }
  }

  RxList allUser = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> data = <DocumentSnapshot>[].obs;
  Future<void> addUserToFireStore() async {
    final snapShop = await users.get();
    data.value = snapShop.docs;
    allUser.assignAll(data.map((element) => (element.data())).toList());

    update();
    String fcmToken = await AppShareData.getFcmToken();
    var addData = {"fcm_tokens": fcmToken};
    bool? isAdded = await _checkDevice(fcmToken);
    if (allUser.isEmpty) {
      await users.add(addData);
    } else {
      if (isAdded!) {
      } else {
        // print("new Device");
        await users.add(addData);
      }
    }
    update();
  }
}
