import 'package:flutter/foundation.dart';

class PopupWheel {
  String title;
  String posterPath;
  double vote;

  PopupWheel({
    required this.title,
    required this.posterPath,
    required this.vote,
  });

  factory PopupWheel.fromJson(Map<String, dynamic> json) {
    return PopupWheel(
        title: json["title"],
        posterPath: json["poster_path"],
        vote: json["vote_average"].toDouble());
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "poster_path": posterPath,
        "vote_average": vote,
      };
}
