import 'package:get/get.dart';
import 'package:weather_app/screens/all_user_sent_noti/sent_noti_page.dart';
import 'package:weather_app/screens/fav_page/fav_page.dart';
import 'package:weather_app/screens/home_screen/home_page.dart';
import 'package:weather_app/screens/search_screen/search_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String search = "/search";
  static const String fav = "/fav";
  static const String noti = "/noti";
  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: search,
        page: () => const SearchPage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: fav,
        page: () => const FavPage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: noti,
        page: () => const SentNotiPage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200)),
  ];
}
