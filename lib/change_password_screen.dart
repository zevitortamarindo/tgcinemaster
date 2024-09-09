import 'package:cinemaster_app/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final txtNameCtrl = TextEditingController();
  final txtEmailCtrl = TextEditingController();
  final txtPasswordCtrl = TextEditingController();
  final txtConfirmPasswordCtrl = TextEditingController();
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 450;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: const Color(0xe5020217),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 50 * fem, 9.5 * fem, 0 * fem),
                  width: 48.5 * fem,
                  height: 58 * fem,
                  child: Image.asset(
                    'lib/assets/images/cinemaster_logo_dark_green-2x.png',
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
                  height: 65,
                ),
                AppText(
                    text: 'Conta e Configurações',
                    color: Colors.white,
                    size: 27 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625 * ffem / fem),
                const SizedBox(
                  height: 1,
                ),
                AppText(
                    text: 'Altere seu email ou senha',
                    color: const Color(0xffc2c2c2),
                    size: 15 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.3625 * ffem / fem),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 245,
                  height: 58,
                  child: TextField(
                    controller: txtEmailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: const Color(0x50c4c4c4),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Digite seu novo email',
                      labelStyle: const TextStyle(
                        color: Color(0xffc2c2c2),
                        fontSize: 13,
                      ),
                      prefixIcon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.mail_outline_rounded,
                          size: 20,
                          color: Color(0xffc2c2c2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 245,
                  height: 58,
                  child: TextField(
                    controller: txtEmailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: const Color(0x50c4c4c4),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Confirme seu novo Email',
                      labelStyle: const TextStyle(
                        color: Color(0xffc2c2c2),
                        fontSize: 13,
                      ),
                      prefixIcon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.mail_outline_rounded,
                          size: 20,
                          color: Color(0xffc2c2c2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 245,
                  height: 58,
                  child: TextField(
                    controller: txtPasswordCtrl,
                    onChanged: (value) {
                      setState() {
                        password = value;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: const Color(0x50c4c4c4),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Digite uma nova Senha',
                      labelStyle: const TextStyle(
                        color: Color(0xffc2c2c2),
                        fontSize: 13,
                      ),
                      prefixIcon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 20,
                          color: Color(0xffc2c2c2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 245,
                  height: 58,
                  child: TextField(
                    controller: txtConfirmPasswordCtrl,
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: const Color(0x50c4c4c4),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Confirme sua nova Senha',
                      labelStyle: const TextStyle(
                        color: Color(0xffc2c2c2),
                        fontSize: 13,
                      ),
                      prefixIcon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 20,
                          color: Color(0xffc2c2c2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  width: 320 * fem,
                  height: 50 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 45 * fem),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 10),
                            ),
                            child: Container(
                              width: 125 * fem,
                              height: 95 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xff009ed0),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: Center(
                                child: AppText(
                                    text: 'Voltar',
                                    color: const Color(0xff1f1d36),
                                    size: 16 * fem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625 * ffem / fem),
                              ),
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          if (1 == 1) {
                            db.collection('users').add({
                              'name': txtNameCtrl.text,
                              'email': txtEmailCtrl.text,
                              'password': txtPasswordCtrl.text,
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ProfileScreen();
                            }));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: const Text('As senhas não coincidem'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 125 * fem,
                          height: 95 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff009ed0),
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                          child: Center(
                            child: AppText(
                                text: 'Alterar Conta',
                                color: const Color(0xff1f1d36),
                                size: 16 * fem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
