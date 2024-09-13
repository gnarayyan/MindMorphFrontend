// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'swiper_model.dart';

class SwiperResponseModel {
  String message;
  bool isSuccess;
  SwiperModel swiper;

  SwiperResponseModel({
    required this.message,
    required this.isSuccess,
    required this.swiper,
  });

  factory SwiperResponseModel._fromJson(
      Map<String, dynamic> json, Response response, int statusCode) {
    // print('Response: ${response.body}');
    return SwiperResponseModel(
      message: json["message"],
      swiper: SwiperModel.fromJson(json["data"]),
      isSuccess: response.statusCode == statusCode,
    );
  }

  factory SwiperResponseModel.fromResponse(Response response, int statusCode) =>
      SwiperResponseModel._fromJson(
          json.decode(response.body), response, statusCode);
}
