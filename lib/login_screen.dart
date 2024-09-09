import 'package:cinemaster_app/forgot_password_screen.dart';
import 'package:cinemaster_app/gnav/gnav.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/selectFilmes.dart';
import 'package:cinemaster_app/services/flutter_fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/utils.dart';
import 'package:cinemaster_app/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _textEmailController = TextEditingController();

  final TextEditingController _textPasswordController = TextEditingController();

  bool _signWithEmailAndPasswordLoading = false;

  bool isPasswordVisible = false;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    void _signInEmailAndPassword() async {
      final email = _textEmailController.text;
      final password = _textPasswordController.text;

      setState(() => _signWithEmailAndPasswordLoading = true);

      final user = await FlutterFireAuth(context)
          .signInWithEmailAndPassword(email, password);

      setState(() => _signWithEmailAndPasswordLoading = false);

      if (user != null) {
        _textEmailController.clear();
        _textPasswordController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleNavBar(),
          ),
        );
      }
    }

    final bool? resizeToAvoidBottomInset;
    double baseWidth = 450;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xe5020217),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                Container(
                  // logotipoverdeescurooTd (14:208)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 100 * fem, 9.5 * fem, 0 * fem),
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
                    text: 'Login',
                    color: Colors.white,
                    size: 27 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625 * ffem / fem),
                const SizedBox(
                  height: 1,
                ),
                AppText(
                    text: 'Por favor conecte-se para continuar',
                    color: const Color(0xffc2c2c2),
                    size: 15 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.3625 * ffem / fem),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 245,
                        height: 55,
                        child: TextFormField(
                          controller: _textEmailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O email é obrigatório';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: const Color(0x50c4c4c4),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Email',
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
                        height: 55,
                        child: TextFormField(
                          controller: _textPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A senha é obrigatória';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: const Color(0x50c4c4c4),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Senha',
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xffc2c2c2),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const ForgotPassword();
                              }),
                            );
                            if (formKey.currentState?.validate() ?? false) {}
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: AppText(
                              text: 'Esqueci minha senha',
                              color: const Color(0xff00d06c),
                              size: 13 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3625 * ffem / fem)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                TextButton(
                  onPressed: _signInEmailAndPassword,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: _signWithEmailAndPasswordLoading
                      ? CircularProgressIndicator()
                      : Container(
                          width: 115 * fem,
                          height: 45 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff00d06c),
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                          child: Center(
                            child: AppText(
                                text: 'Entrar',
                                color: const Color(0xff1f1d36),
                                size: 18 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 10 * fem, right: 0 * fem, bottom: 12 * fem),
                  width: 192.5 * fem,
                  height: 38 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: SafeGoogleFont(
                              'Open Sans',
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3618164062 * ffem / fem,
                              color: const Color(0xffe9a6a6),
                            ),
                            children: [
                              TextSpan(
                                text: 'Não tem uma conta?',
                                style: SafeGoogleFont(
                                  'Open Sans',
                                  fontSize: 12 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625 * ffem / fem,
                                  color: const Color(0xffc2c2c2),
                                ),
                              ),
                              TextSpan(
                                text: '',
                                style: SafeGoogleFont(
                                  'Open Sans',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625 * ffem / fem,
                                  color: const Color(0xffe9a6a6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const SignUpScreen();
                              }),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: AppText(
                            text: 'Cadastre-se',
                            color: const Color(0xff00d06c),
                            size: 12 * fem,
                            fontWeight: FontWeight.w700,
                            height: 1.3625 * ffem / fem,
                          ))
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
