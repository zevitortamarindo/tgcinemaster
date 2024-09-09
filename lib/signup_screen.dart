import 'package:cinemaster_app/gnav/gnav.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/models/user_data.dart';
import 'package:cinemaster_app/selectStreamings.dart';
import 'package:cinemaster_app/services/flutter_fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/utils.dart';
import 'package:cinemaster_app/login_screen.dart';
import 'package:validatorless/validatorless.dart';
import 'package:cinemaster_app/selectFilmes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _txtNameCtrl = TextEditingController();
  final _txtEmailCtrl = TextEditingController();
  final _txtPasswordCtrl = TextEditingController();
  final _txtConfirmPasswordCtrl = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _txtNameCtrl.dispose();
    _txtEmailCtrl.dispose();
    _txtPasswordCtrl.dispose();
    _txtConfirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 450;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    void _navigateToHome() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GoogleNavBar(),
        ),
      );
    }

    void _navigateToSelectStreamings() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SelectStreaming(),
        ),
      );
    }

    void _submit() async {
      final name = _txtNameCtrl.text;
      final email = _txtEmailCtrl.text;
      final password = _txtPasswordCtrl.text;

      setState(() => _isLoading = true);

      final user = await FlutterFireAuth(context)
          .createUserWithEmailAndPassword(name, email, password);

      setState(() => _isLoading = false);

      if (user != null) {
        _navigateToSelectStreamings();
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xe5020217),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                      text: 'Criar Conta',
                      color: Colors.white,
                      size: 27 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625 * ffem / fem),
                  const SizedBox(
                    height: 1,
                  ),
                  AppText(
                      text: 'Crie uma conta para continuar',
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
                    child: TextFormField(
                      controller: _txtNameCtrl,
                      validator:
                          Validatorless.required('O nome não pode ser vazio'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: const Color(0x50c4c4c4),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Digite seu Nome',
                        labelStyle: const TextStyle(
                          color: Color(0xffc2c2c2),
                          fontSize: 13,
                        ),
                        prefixIcon: const SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            Icons.person_rounded,
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
                    child: TextFormField(
                      controller: _txtEmailCtrl,
                      validator: Validatorless.multiple([
                        Validatorless.required('O Email não pode ser vazio'),
                        Validatorless.email('Digite um Email válido')
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: const Color(0x50c4c4c4),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Digite seu Email',
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
                    child: TextFormField(
                      controller: _txtPasswordCtrl,
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha não pode ser vazia'),
                        Validatorless.min(
                            8, 'Insira uma senha de no mínimo 8 caracteres')
                      ]),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: const Color(0x50c4c4c4),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Crie uma Senha',
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
                    child: TextFormField(
                      controller: _txtConfirmPasswordCtrl,
                      validator: Validatorless.multiple([
                        Validatorless.required(
                            'Confirme a senha, por gentileza'),
                        Validatorless.compare(
                            _txtPasswordCtrl, 'As senhas não coincidem')
                      ]),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: const Color(0x50c4c4c4),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Confirme sua Senha',
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
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }));
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
                            var formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              _submit();
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Container(
                                  width: 125 * fem,
                                  height: 95 * fem,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff009ed0),
                                    borderRadius:
                                        BorderRadius.circular(30 * fem),
                                  ),
                                  child: Center(
                                    child: AppText(
                                        text: 'Criar Conta',
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
      ),
    );
  }
}
