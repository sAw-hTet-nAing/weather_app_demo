import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/app_constant.dart';

class AppShareData {
  static Future<void> setPermission(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("permission", value);
    AppConstant.permission = value;
  }

  static Future<bool> getPermission() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppConstant.permission = pref.getBool("permission") ?? false;
    return AppConstant.permission;
  }

  static Future<void> setDefaultLat(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("lat", value);
    AppConstant.defaultLat = value;
  }

  static Future<String> getDefaultlat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppConstant.defaultLat = pref.getString("lat") ?? "";
    return AppConstant.defaultLat;
  }

  static Future<void> setDefaultlong(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("long", value);
    AppConstant.defaultLong = value;
  }

  static Future<String> getDefaultlong() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppConstant.defaultLong = pref.getString("long") ?? "";
    return AppConstant.defaultLong;
  }

  static Future<void> setFcmToken(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fcm", value);
    AppConstant.fcmToken = value;
  }

  static Future<String> getFcmToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppConstant.fcmToken = pref.getString("fcm") ?? "";
    return AppConstant.fcmToken;
  }
}
