import 'dart:convert';

import 'package:cinemaster_app/movie_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:http/http.dart' as http;

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List<Map<String, dynamic>> watchlistData = [];
  Map<int, Map<String, dynamic>> movieDetailsMap = {};

  Future<void> updateWatchlist(String userId) async {
    await getWatchlistFromFirebase(userId);
  }

  Future<void> getWatchlistFromFirebase(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await users.doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      List<Map<String, dynamic>> watchlist =
          (userData['filmes_watchlist'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();

      await Future.wait(watchlist.map((item) async {
        int movieId = item['id'];
        String mediaType = item['type'];

        try {
          if (!movieDetailsMap.containsKey(movieId)) {
            print('Carregando detalhes para o filme $movieId...');
            Map<String, dynamic> movieDetails =
                await getMovieDetailsFromTMDb(movieId, mediaType);
            movieDetailsMap[movieId] = movieDetails;
            print('Detalhes carregados para o filme $movieId: $movieDetails');
          } else {
            print('Detalhes do filme $movieId já estão carregados.');
          }
        } catch (e) {
          print('Erro ao carregar detalhes para o filme $movieId: $e');
        }
      }));

      setState(() {
        watchlistData = watchlist;
      });
    }
  }

  Future<Map<String, dynamic>> getMovieDetailsFromTMDb(
      int movieId, String mediaType) async {
    String apiKey = 'e90fb2a07f28a7e12c61965533ba0079';
    String baseUrl = 'https://api.themoviedb.org/3';
    final language = 'pt-BR';

    String mediaTypePath = (mediaType == 'movies') ? 'movie' : 'tv';

    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/$mediaTypePath/$movieId?api_key=$apiKey&language=$language'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro na resposta da API: ${response.statusCode}');
        print('Corpo da resposta: ${response.body}');
        throw Exception('Erro ao obter detalhes do filme/série');
      }
    } catch (e) {
      print('Erro na requisição da API: $e');
      throw Exception('Erro ao obter detalhes do filme/série');
    }
  }

  @override
  void initState() {
    super.initState();

    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    getWatchlistFromFirebase(userId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    getWatchlistFromFirebase(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 2, 23, 0.9),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 2, 23, 0.9),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 30,
              child: Image.asset(
                'lib/assets/images/cinemaster_logo_dark_green-2x.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              child: const Text(
                'Minha Watchlist',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      body: watchlistData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: watchlistData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> watchlistItem = watchlistData[index];
                int movieId = watchlistItem['id'];
                String mediaType = watchlistItem['type'];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MovieDetails(
                            movieId: movieId,
                            mediaType: mediaType,
                          );
                        }),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movieDetailsMap[movieId]?['poster_path']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            mediaType == 'movies'
                                ? (movieDetailsMap[movieId]?['title'] ??
                                    'Title not available')
                                : (movieDetailsMap[movieId]?['name'] ??
                                    'Name not available'),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
