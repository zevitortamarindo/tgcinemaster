// ignore_for_file: unused_element

import 'dart:math';

import 'package:cinemaster_app/api/api.dart';
import 'package:cinemaster_app/controller/navbar_controller.dart';
import 'package:cinemaster_app/models/popupwheel.dart';
import 'package:cinemaster_app/movie_wheel.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:cinemaster_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_api/tmdb_api.dart';

class WheelScreen extends StatefulWidget {
  WheelScreen({super.key});

  @override
  _WheelScreenState createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool wheel = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 450;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xe5020217),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 100 * fem, 9.5 * fem, 0 * fem),
              child: Image.asset(
                'lib/assets/images/iconeCinemaster.png',
                width: 55.5 * fem,
                height: 62 * fem,
              ),
            ),
            AppText(
              text: 'ROLETA MASTER',
              color: const Color(0xff00d06c),
              size: 32 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.3625 * ffem / fem,
              // cinemasteri4o (14:212)
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              margin: EdgeInsets.only(right: 210 * fem, bottom: 68 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 400 * fem,
              ),
              child: Text('Não se preocupe, vamos escolher um filme pra você',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont('Open Sans',
                      color: Colors.white,
                      fontSize: 25 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625 * ffem / fem)),
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              margin: EdgeInsets.only(left: 7 * fem, bottom: 60 * fem),
              width: 210 * fem,
              height: 190 * fem,
              child: Lottie.network(
                'https://lottie.host/6453bcf5-afd3-4e3c-bf56-8075e8937af0/j7MFSOyo1y.json',
                controller: _controller,
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    if (wheel == false) {
                      wheel = true;
                      _controller.forward();
                    } else {
                      wheel = false;
                      _controller.reverse();
                    }
                    final delay = Duration(seconds: 3);
                    Future.delayed(delay, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MovieWheelScreen();
                        }),
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 135 * fem,
                    height: 60 * fem,
                    decoration: BoxDecoration(
                        color: const Color(0xff00d06c),
                        borderRadius: BorderRadius.circular(30 * fem)),
                    child: Center(
                      child: AppText(
                          text: 'Girar',
                          color: const Color(0xff1f1d36),
                          size: 23 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3625 * ffem / fem),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
