import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/dimesion.dart';
import 'package:weather_app/utils/text_style.dart';

class NotiServices {
  static notiInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

      BotToast.showNotification(
        backgroundColor: Colors.grey[800],
        duration: const Duration(seconds: 4),
        leading: (_) => Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          child: SizedBox(
            height: Dimesion.height40,
            width: Dimesion.height40,
            child: Text(
              "Saw",
              style: MyTextStyle.heading,
            ),
          ),
        ),
        title: (_) => Text(
          title!,
          style: TextStyle(
              fontSize: Dimesion.font16,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        subtitle: (_) => Text(
          description!,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        // trailing: (_) => SizedBox(
        //     height: Dimesion.height40 * 2,
        //     width: Dimesion.height40 * 1.5,
        //     child:
        //         Image.network(remoteMessage.notification!.android!.imageUrl!)),
      );
    });
  }
}
