// ignore_for_file: unused_element

import 'dart:math';

import 'package:cinemaster_app/api/api.dart';
import 'package:cinemaster_app/controller/navbar_controller.dart';
import 'package:cinemaster_app/models/popupwheel.dart';
import 'package:cinemaster_app/movie_details.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:cinemaster_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieWheelScreen extends StatefulWidget {
  MovieWheelScreen({super.key});

  @override
  _MovieWheelScreenState createState() => _MovieWheelScreenState();
}

class _MovieWheelScreenState extends State<MovieWheelScreen>
    with SingleTickerProviderStateMixin {
  List topratedMovies = [];
  late int indexSorteado;
  late int pageNumber;

  @override
  void initState() {
    pageNumber = Random().nextInt(50) + 1;
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(Constants.apiKey, Constants.readAccessToken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated(
      language: 'pt-BR',
      page: pageNumber,
    );
    if (mounted) {
      setState(() {
        topratedMovies = topratedresult['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (topratedMovies.isEmpty) {
      // Se os dados ainda não foram carregados, pode exibir um indicador de carregamento
      return CircularProgressIndicator();
    } else {
      Random random = Random();
      indexSorteado = random.nextInt(1001);

      // Certifique-se de que o índice sorteado está dentro dos limites da lista
      indexSorteado = indexSorteado.clamp(0, topratedMovies.length - 1);
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
              Container(
                margin: EdgeInsets.only(right: 210 * fem, bottom: 33 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400 * fem,
                ),
                child: Text('O filme escolhido foi...',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont('Open Sans',
                        color: Colors.white,
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625 * ffem / fem)),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MovieDetails(
                        movieId: topratedMovies[indexSorteado]['id'],
                        mediaType: 'movies',
                      );
                    }),
                  );
                },
                child: Container(
                  height: 260,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500' +
                        topratedMovies[indexSorteado]['poster_path'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400 * fem,
                ),
                child: Text(
                  topratedMovies[indexSorteado]['title'],
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Open Sans',
                    color: Colors.white,
                    fontSize: 26 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625 * ffem / fem,
                  ),
                  maxLines: null, // Permite quebra de linha
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 10),
                  ),
                  child: Container(
                    width: 120 * fem,
                    height: 55 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xff009ed0),
                      borderRadius: BorderRadius.circular(30 * fem),
                    ),
                    child: Center(
                      child: AppText(
                          text: 'Voltar',
                          color: const Color(0xff1f1d36),
                          size: 19 * fem,
                          fontWeight: FontWeight.w700,
                          height: 1.3625 * ffem / fem),
                    ),
                  )),
            ],
          ),
        ),
      );
    }
  }
}
