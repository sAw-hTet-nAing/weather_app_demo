import 'package:get/get.dart';
import 'package:weather_app/network/api_client.dart';
import 'package:weather_app/utils/app_constant.dart';

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<Response> getCurrentWeather({required String q}) async {
    String endPoint = "current.json?key=${AppConstant.apiKey}&q=$q&aqi=yes";
    return await apiClient.getData(endPoint);
  }

  Future<Response> getForecastWeather({required String q}) async {
    String endPoint =
        "forecast.json?key=${AppConstant.apiKey}&q=$q&days=7&aqi=no&alerts=no";

    return await apiClient.getData(endPoint);
  }
}
