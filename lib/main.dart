import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/routes/route_helper.dart';
import 'package:weather_app/screens/home_screen/home_page.dart';
import 'package:weather_app/services/db_services.dart';
import 'package:weather_app/services/noti_services.dart';
import 'package:weather_app/services/share_data_services.dart';
import 'app_binding/app_binding.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  await dep.init();
  await DBService.initDb();

  await FirebaseMessaging.instance.getToken().then((value) async {
    var token = await AppShareData.getFcmToken();
    if (token == "") {
      await AppShareData.setFcmToken(value!);
    }
  });
  await NotiServices.notiInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      getPages: RouteHelper.routes,
      initialRoute: RouteHelper.initial,
      home: const HomePage(),
    );
  }
}
