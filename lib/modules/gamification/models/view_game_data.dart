// To parse this JSON data, do
//
//     final viewGameModel = viewGameModelFromJson(jsonString);

import 'dart:convert';

class ViewGameModel {
  int id;
  String text;
  String? imageUrl;
  int gameId;

  ViewGameModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.gameId,
  });

  factory ViewGameModel._fromJson(Map<String, dynamic> json) => ViewGameModel(
        id: json["id"] ?? -1,
        text: json["text"],
        imageUrl: json["imageUrl"],
        gameId: json["gameId"],
      );

  factory ViewGameModel.fromResponseBody(String str) =>
      ViewGameModel._fromJson(json.decode(str));
}
