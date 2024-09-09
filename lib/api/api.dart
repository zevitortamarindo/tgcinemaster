import 'dart:convert';
import 'package:cinemaster_app/widgets/constants.dart';
import 'package:cinemaster_app/models/popupwheel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _topratedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  Future<List<PopupWheel>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topratedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData
          .map((popupmovie) => PopupWheel.fromJson(popupmovie))
          .toList();
    } else {
      throw Exception('Alguma coisa deu errado');
    }
  }
}
