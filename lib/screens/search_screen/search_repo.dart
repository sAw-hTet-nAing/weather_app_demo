import 'package:get/get.dart';
import 'package:weather_app/models/search_model.dart';
import 'package:weather_app/network/api_client.dart';
import 'package:weather_app/utils/app_constant.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient});
  Future<Response> search({required String q}) async {
    String endPoint = "search.json?key=${AppConstant.apiKey}&q=$q";
    return await apiClient.getData(endPoint);
  }

  List<SearchModel> parseResponse(responseBody) {
    final parsed = responseBody.cast<Map<String, dynamic>>();
    return parsed
        .map<SearchModel>((json) => SearchModel.fromJson(json))
        .toList();
  }
}
