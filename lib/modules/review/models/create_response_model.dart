import 'dart:convert';

import 'package:http/http.dart';

class ResponseModel<T> {
  String message;
  bool isFailure;
  T? data;

  ResponseModel({required this.message, required this.isFailure, this.data});

  factory ResponseModel.fromResponse(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    String message = jsonData["message"];
    bool isFailure = (response.statusCode == 201) ? false : true;
    return ResponseModel(
      message: message,
      isFailure: isFailure,
      data: fromJson(jsonData["result"]),
    );
  }
}



////

// class ResponseModel {
//   String message;
//   bool isFailure;
//   Reply? reply;

//   ResponseModel({required this.message, required this.isFailure, this.reply});

//   factory ResponseModel.fromResponse(Response response) {
//     Map<String, dynamic> jsonData = json.decode(response.body);
//     String message = jsonData["message"];
//     bool isFailure = (response.statusCode == 201) ? false : true;
//     return ResponseModel(
//       message: message,
//       isFailure: isFailure,
//       reply: Reply.fromJson(jsonData["result"]),
//     );
//   }
// }
