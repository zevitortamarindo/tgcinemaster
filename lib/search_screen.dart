// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/movie_details.dart';
import 'package:cinemaster_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cinemaster_app/widgets/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

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
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Pesquise aqui',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IconButton(
                  onPressed: () {
                    _searchMovies();
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 50, 30),
                  height: 100,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MovieDetails(
                            movieId: searchResults[index]['id'],
                            mediaType: 'movies',
                          );
                        }),
                      );
                    },
                    child: Row(
                      children: [
                        Image.network(
                          '${Constants.imagePath}${searchResults[index]['poster_path']}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Expanded(
                              child: Text(
                                searchResults[index]['title'],
                                style: subTitleStyle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final String apiKey = Constants.apiKey;
    final String baseUrl = 'https://api.themoviedb.org/3/search/movie';

    final Uri uri = Uri.parse('$baseUrl?api_key=$apiKey&query=$query');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Falha ao carregar os filmes');
    }
  }

  Future<void> _searchMovies() async {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      List<dynamic> results = await searchMovies(query);

      // Filtra resultados para incluir apenas filmes com poster_path não vazio
      List<dynamic> filteredResults = results.where((movie) {
        return movie['poster_path'] != null && movie['poster_path'].isNotEmpty;
      }).toList();

      setState(() {
        searchResults = filteredResults;
      });
    }
  }
}
