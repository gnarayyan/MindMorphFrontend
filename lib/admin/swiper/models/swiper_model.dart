import 'dart:convert';

class SwiperModel {
  int id;
  String image;

  SwiperModel({
    required this.id,
    required this.image,
  });

  factory SwiperModel.fromJson(Map<String, dynamic> json) => SwiperModel(
        id: json["id"],
        image: json["image"],
      );

  static List<SwiperModel> fromResponseBody(String str) =>
      List<SwiperModel>.from(
          json.decode(str).map((x) => SwiperModel.fromJson(x)));
}
