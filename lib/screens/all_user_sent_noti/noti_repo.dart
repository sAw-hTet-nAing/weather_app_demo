import 'package:get/get.dart';
import 'package:weather_app/network/noti_api_client.dart';

class NotiRepo {
  final NotiApiClient notiapiClient;
  NotiRepo({required this.notiapiClient});

  Future<Response> sentNoti(
      {required String body,
      required String title,
      required String fcm}) async {
    return await notiapiClient.postData("/fcm/send", {
      "to": fcm,
      "notification": {
        "body": body,
        "title": title,
      },
    });
  }
}
