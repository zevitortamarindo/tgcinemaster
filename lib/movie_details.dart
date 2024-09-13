import 'dart:convert';
import 'package:cinemaster_app/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  final String mediaType;

  const MovieDetails({Key? key, required this.movieId, required this.mediaType})
      : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Map<String, dynamic>? movieDetails;
  bool isAddedToWatchlist = false;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final apiKey = 'e90fb2a07f28a7e12c61965533ba0079';
      final language = 'pt-BR';

      String baseUrl;

      if (widget.mediaType == 'tv') {
        baseUrl = 'https://api.themoviedb.org/3/tv/';
      } else if (widget.mediaType == 'movies') {
        baseUrl = 'https://api.themoviedb.org/3/movie/';
      } else {
        // Lógica de tratamento para tipos desconhecidos, se necessário
        print('Tipo de mídia desconhecido: ${widget.mediaType}');
        return;
      }

      final url =
          '$baseUrl${widget.movieId}?api_key=$apiKey&language=$language';

      final url_cast =
          '$baseUrl${widget.movieId}/credits?api_key=$apiKey&$language';

      print('URL da requisição do filme: $url');
      print('URL da requisição do elenco do filme: $url_cast');

      final response = await http.get(Uri.parse(url));
      final response_cast = await http.get(Uri.parse(url_cast));

      if (response.statusCode == 200 && response_cast.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> data_cast = json.decode(response_cast.body);

        // Adicione este log para ver a estrutura completa dos dados
        print('Dados completos do filme: $data');
        print('Dados completos do elenco do filme: $data_cast');

        final List<dynamic> castMembers = data_cast['cast'].take(5).toList();

        final Map<String, dynamic> combinedData = {
          ...data,
          'cast': castMembers
        };

        setState(() {
          movieDetails = combinedData;
          checkWatchlistStatus();
        });
      } else {
        print(
            'Falha ao carregar detalhes do filme. Status codes: ${response.statusCode}, ${response_cast.statusCode}');
        throw Exception('Falha ao carregar detalhes do filme');
      }
    } catch (e) {
      print('Erro ao carregar detalhes do filme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromRGBO(3, 2, 23, 0.9);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: movieDetails == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        // 'lib/assets/images/batman.png',
                        'https://image.tmdb.org/t/p/w500${movieDetails!['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backgroundColor, // Cor de fundo roxo
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white, // Cor da seta verde
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.mediaType == 'tv'
                                ? movieDetails!['name']
                                : movieDetails!['title'],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            movieDetails!['overview'],
                            style:
                                TextStyle(fontSize: 15, color: Colors.white70),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.mediaType == 'tv'
                                          ? '(${DateFormat('yyyy').format(DateTime.parse(movieDetails!['first_air_date']))})'
                                          : '(${DateFormat('yyyy').format(DateTime.parse(movieDetails!['release_date']))})',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white70),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.mediaType == 'tv'
                                          // movieDetails!['number_os_seasons']
                                          ? '${movieDetails!['number_of_seasons']} ${movieDetails!['number_of_seasons'] == 1 ? 'temporada' : 'temporadas'}'
                                          : '${(movieDetails!['runtime'] ~/ 60)}h ${(movieDetails!['runtime'] % 60)}m',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white70),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 35,
                                          child: Image.asset(
                                            'lib/assets/images/imdb_img.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(movieDetails!['vote_average']
                                            .toStringAsFixed(1)),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 13,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await updateWatchlist();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: isAddedToWatchlist
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Watchlist',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 300,
                                  child: Text(
                                    // 'generos',
                                    movieDetails!['genres']
                                        .map((genre) => genre['name'])
                                        .join(', '),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white70),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Row(
                              children: [
                                Text(
                                  'Elenco',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              height: 99,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movieDetails!['cast'].length,
                                itemExtent:
                                    180, // Largura fixa para cada cartão
                                itemBuilder: (BuildContext context, int index) {
                                  var cast = movieDetails!['cast'][index];
                                  return buildCard(
                                      cast['name'], cast['character']);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void checkWatchlistStatus() async {
    final userWatchlistRef =
        FirebaseFirestore.instance.collection('users').doc(_user?.uid);

    // Obtém os itens da watchlist atuais do usuário
    final currentWatchlist = (await userWatchlistRef.get())
            .data()?['filmes_watchlist']
            ?.cast<Map<String, dynamic>>() ??
        [];

    setState(() {
      isAddedToWatchlist = currentWatchlist.any((item) =>
          item['id'] == widget.movieId && item['type'] == widget.mediaType);
    });
  }

  updateWatchlist() async {
    final userWatchlistRef =
        FirebaseFirestore.instance.collection('users').doc(_user?.uid);

    // Obtém os itens da watchlist atuais do usuário
    final currentWatchlist = (await userWatchlistRef.get())
            .data()?['filmes_watchlist']
            ?.cast<Map<String, dynamic>>() ??
        [];

    final contentInfo = {
      'id': widget.movieId,
      'type': widget.mediaType,
    };

    // Verifica se o conteúdo já está na watchlist
    final indexToRemove = currentWatchlist.indexWhere((item) =>
        item['id'] == contentInfo['id'] && item['type'] == contentInfo['type']);

    if (indexToRemove != -1) {
      // Remove o conteúdo da watchlist
      currentWatchlist.removeAt(indexToRemove);
    } else {
      // Adiciona o conteúdo à watchlist
      currentWatchlist.add(contentInfo);
    }

    // Atualiza o campo filmes_watchlist no documento do usuário
    await userWatchlistRef.update({'filmes_watchlist': currentWatchlist});

    // Verifica novamente o estado do botão Watchlist
    setState(() {
      isAddedToWatchlist = currentWatchlist.any((item) =>
          item['id'] == widget.movieId && item['type'] == widget.mediaType);
    });
  }
}

Widget buildCard(String ator, String personagem) => Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 90,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(31, 28, 70, 0.961),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ator,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                personagem,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
