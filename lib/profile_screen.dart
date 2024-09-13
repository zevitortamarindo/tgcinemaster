import 'package:cinemaster_app/change_password_screen.dart';
import 'package:cinemaster_app/login_screen.dart';
import 'package:cinemaster_app/services/flutter_fire_auth.dart';
import 'package:cinemaster_app/udpate_streamings_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cinemaster_app/utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      await FlutterFireAuth(context).signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }

    final user = FirebaseAuth.instance.currentUser;

    double baseWidth = 450;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xe5020217),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 100 * fem, 9.5 * fem, 0 * fem),
                // width: 48.5 * fem,
                // height: 58 * fem,
                child: Image.asset(
                  'lib/assets/images/iconeCinemaster.png',
                  width: 55.5 * fem,
                  height: 62 * fem,
                ),
              ),
              AppText(
                text: 'CINEMASTER',
                color: const Color(0xff00d06c),
                size: 32 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.3625 * ffem / fem,
                // cinemasteri4o (14:212)
              ),
              const SizedBox(
                height: 35,
              ),
              AppText(
                  text: 'Olá, ${user?.displayName ?? "User name not find"}',
                  color: Colors.white,
                  size: 28 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3625 * ffem / fem),
              const SizedBox(
                height: 45,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 47 * fem),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdateStreamingScreen();
                    }));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 12 * fem, 39 * fem, 13 * fem),
                    width: 355 * fem,
                    height: 68 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0x1eeeeadd),
                      borderRadius: BorderRadius.circular(10 * fem),
                      border: const Border(),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2.4049999714 * fem,
                          sigmaY: 2.4049999714 * fem,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 3 * fem, right: 8 * fem),
                              width: 28 * fem,
                              height: 28 * fem,
                              child: Icon(
                                Icons.monitor_outlined,
                                color: Colors.white,
                                size: 28 * fem,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  9 * fem, 0 * fem, 0 * fem, 1 * fem),
                              child: Text(
                                'Serviços de Streaming',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Open Sans',
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3625 * ffem / fem,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40 * fem),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChangePasswordScreen();
                    }));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 0 * fem, 10 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 12 * fem, 39 * fem, 13 * fem),
                    width: 355 * fem,
                    height: 68 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0x1eeeeadd),
                      borderRadius: BorderRadius.circular(10 * fem),
                      border: const Border(),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2.4049999714 * fem,
                          sigmaY: 2.4049999714 * fem,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 3 * fem, right: 8 * fem),
                              width: 28 * fem,
                              height: 28 * fem,
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                                size: 28 * fem,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  9 * fem, 0 * fem, 0 * fem, 1 * fem),
                              child: Text(
                                'Conta e configurações',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Open Sans',
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3625 * ffem / fem,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30 * fem),
                child: TextButton(
                  onPressed: _signOut,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 0 * fem, 10 * fem),
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 12 * fem, 39 * fem, 13 * fem),
                    width: 355 * fem,
                    height: 68 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0x1eeeeadd),
                      borderRadius: BorderRadius.circular(10 * fem),
                      border: const Border(),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2.4049999714 * fem,
                          sigmaY: 2.4049999714 * fem,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 3 * fem, right: 8 * fem),
                              width: 28 * fem,
                              height: 28 * fem,
                              child: Icon(
                                Icons.exit_to_app_rounded,
                                color: Colors.white,
                                size: 28 * fem,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  9 * fem, 0 * fem, 0 * fem, 1 * fem),
                              child: Text(
                                'Sair',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Open Sans',
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3625 * ffem / fem,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
