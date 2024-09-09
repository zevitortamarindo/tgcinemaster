// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinemaster_app/api/api.dart';
import 'package:cinemaster_app/controller/navbar_controller.dart';
import 'package:cinemaster_app/models/streaming.dart';
import 'package:cinemaster_app/movie_details.dart';
import 'package:cinemaster_app/search_screen.dart';
import 'package:cinemaster_app/styles.dart';
import 'package:cinemaster_app/widgets/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Home extends StatefulWidget {
  Home({super.key}) {}

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List popularmovies = [];
  List topratedmovies = [];
  List populartv = [];
  List topratedtv = [];
  List upcoming = [];

  String apiKey = Constants.apiKey;
  String readAccessToken = Constants.readAccessToken;

  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map popularmoviesresult =
        await tmdbWithCustomLogs.v3.movies.getPopular(language: 'pt-br');
    Map topratedresult =
        await tmdbWithCustomLogs.v3.movies.getTopRated(language: 'pt-br');
    Map populartvresult =
        await tmdbWithCustomLogs.v3.tv.getPopular(language: 'pt-br');
    Map topratedtvresult =
        await tmdbWithCustomLogs.v3.tv.getTopRated(language: 'pt-br');
    Map upcomingresult =
        await tmdbWithCustomLogs.v3.movies.getUpcoming(language: 'pt-br');

    setState(() {
      popularmovies = popularmoviesresult['results'];
      topratedmovies = topratedresult['results'];
      populartv = populartvresult['results'];
      topratedtv = topratedtvresult['results'];
      upcoming = upcomingresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/assets/images/iconeCinemaster.png',
                width: 39.27,
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SearchScreen();
                      }),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: popularmovies.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(23, 20, 23, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Filmes Populares',
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: popularmovies.length,
                        options: CarouselOptions(
                          height: 350, // Altura do carrossel
                          aspectRatio: 9 / 6, // Proporção
                          viewportFraction: 0.55, // Fração de visão por slide
                          initialPage: 0, // Página inicial
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false, // Ampliar a página central
                          scrollDirection:
                              Axis.horizontal, // Direção de rolagem
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetails(
                                        movieId: popularmovies[index]['id'],
                                        mediaType: 'movies',
                                      );
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${popularmovies[index]['poster_path']}',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${popularmovies[index]['title']}',
                                    style: simpleStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      //
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Filmes Mais Bem Avaliados',
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: topratedmovies.length,
                        options: CarouselOptions(
                          height: 350, // Altura do carrossel
                          aspectRatio: 9 / 6, // Proporção
                          viewportFraction: 0.55, // Fração de visão por slide
                          initialPage: 0, // Página inicial
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false, // Ampliar a página central
                          scrollDirection:
                              Axis.horizontal, // Direção de rolagem
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetails(
                                        movieId: topratedmovies[index]['id'],
                                        mediaType: 'movies',
                                      );
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${topratedmovies[index]['poster_path']}',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${topratedmovies[index]['title']}',
                                    style: simpleStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Séries Populares',
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: populartv.length,
                        options: CarouselOptions(
                          height: 350, // Altura do carrossel
                          aspectRatio: 9 / 6, // Proporção
                          viewportFraction: 0.55, // Fração de visão por slide
                          initialPage: 0, // Página inicial
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false, // Ampliar a página central
                          scrollDirection:
                              Axis.horizontal, // Direção de rolagem
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetails(
                                          movieId: populartv[index]['id'],
                                          mediaType: 'tv');
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${populartv[index]['poster_path']}',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${populartv[index]['name']}',
                                    style: simpleStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Séries Mais Bem Avaliadas',
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: topratedtv.length,
                        options: CarouselOptions(
                          height: 350, // Altura do carrossel
                          aspectRatio: 9 / 6, // Proporção
                          viewportFraction: 0.55, // Fração de visão por slide
                          initialPage: 0, // Página inicial
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false, // Ampliar a página central
                          scrollDirection:
                              Axis.horizontal, // Direção de rolagem
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetails(
                                        movieId: topratedtv[index]['id'],
                                        mediaType: 'tv',
                                      );
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${topratedtv[index]['poster_path']}',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${topratedtv[index]['name']}',
                                    style: simpleStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Próximos Lançamentos',
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: upcoming.length,
                        options: CarouselOptions(
                          height: 350, // Altura do carrossel
                          aspectRatio: 9 / 6, // Proporção
                          viewportFraction: 0.55, // Fração de visão por slide
                          initialPage: 0, // Página inicial
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false, // Ampliar a página central
                          scrollDirection:
                              Axis.horizontal, // Direção de rolagem
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetails(
                                        movieId: upcoming[index]['id'],
                                        mediaType: 'movies',
                                      );
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${upcoming[index]['poster_path']}',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${upcoming[index]['title']}',
                                    style: simpleStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// Antigo Builder
// CarouselSlider(
//   options: CarouselOptions(
//     height: 250, // Altura do carrossel
//     aspectRatio: 9 / 6, // Proporção
//     viewportFraction: 0.4, // Fração de visão por slide
//     initialPage: 1, // Página inicial
//     enableInfiniteScroll: false,
//     enlargeCenterPage: false, // Ampliar a página central
//     scrollDirection: Axis.horizontal, // Direção de rolagem
//   ),
//   items: widget.filmes.map((filme) {
//     return Builder(
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 12),
//           child: Column(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) {
//                         return MovieDetails();
//                       }),
//                     );
//                   },
//                   child: Image.network(filme.image!)),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   filme.title!,
//                   style: simpleStyle,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }).toList(),
// ),
