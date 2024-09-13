// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

class ResponseModel {
  String message;
  bool isSuccess;

  ResponseModel({required this.message, required this.isSuccess});

  factory ResponseModel.fromResponse(Response response,
      {createRequest = false}) {
    final message = json.decode(response.body)["message"];
    bool isSuccess =
        createRequest ? response.statusCode == 201 : response.statusCode == 200;
    return ResponseModel(message: message, isSuccess: isSuccess);
  }
}
