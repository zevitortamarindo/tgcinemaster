import 'package:cinemaster_app/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cinemaster_app/controller/navbar_controller.dart';

class GoogleNavBar extends StatelessWidget {
  const GoogleNavBar({Key? key}) : super(key: key);

  // final UserData user;

  @override
  Widget build(BuildContext context) {
    NavBarController controller = Get.put(NavBarController());
    controller.index.value = 0;

    return Scaffold(
      bottomNavigationBar: GNav(
        iconSize: 20,
        backgroundColor: Color(0xff1f1d36),
        color: Colors.white,
        activeColor: Color(0xff00d06c),
        onTabChange: (value) {
          controller.index.value = value;
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Início',
            gap: 5,
          ),
          GButton(
            icon: Icons.bookmark_outline_rounded,
            text: 'Watchlist',
            gap: 5,
          ),
          GButton(
            icon: Icons.support_outlined,
            text: 'Roleta',
            gap: 5,
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
            gap: 5,
          ),
        ],
      ),
      body: Obx(
        () => controller.pages[controller.index.value],
      ),
    );
  }
}
