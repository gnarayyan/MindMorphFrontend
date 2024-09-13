// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CreateGameModel {
  String text;
  int courseCategoryId;
  File? image;
  CreateGameModel({
    required this.text,
    required this.courseCategoryId,
    this.image,
  });

  Future<List<http.MultipartFile>> get files async {
    if (image == null) throw 'Image doens\'t Exist';
    return [
      await http.MultipartFile.fromPath('image', image!.path,
          contentType: MediaType('image', 'jpeg')),
    ];
  }

  Map<String, String> get createFields {
    return {
      'text': text,
      'courseCategoryId': courseCategoryId.toString(),
    };
  }

  String toJsonBody() {
    Map<String, dynamic> data = {
      'text': text,
      'courseCategoryId': courseCategoryId,
    };

    return jsonEncode(data);
  }
}
