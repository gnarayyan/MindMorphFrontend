import 'package:http/http.dart';
import 'dart:convert';

class ResponseModel {
  String message;
  bool isSuccess;

  ResponseModel({required this.message, required this.isSuccess});

  factory ResponseModel._fromJson(
      Map<String, dynamic> json, Response response) {
    // print('Response: ${response.body}');
    return ResponseModel(
        message: json["message"], isSuccess: response.statusCode == 200);
  }

  factory ResponseModel.fromResponse(Response response) =>
      ResponseModel._fromJson(json.decode(response.body), response);
}
