import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    Home(),
    Watchlist(),
    WheelScreen(),
    ProfileScreen(),
  ];
}
