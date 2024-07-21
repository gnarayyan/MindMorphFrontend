import 'dart:convert';

import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

class CreateReviewModel {
  int courseId;
  String content;
  double rating;

  CreateReviewModel({
    required this.courseId,
    required this.content,
    required this.rating,
  });

  Future<Map<String, dynamic>> _toJson() async => {
        "courseId": courseId,
        "userId": await UserStorage.userId,
        "content": content,
        "rating": rating,
      };

  Future<String> toRequestBody() async => json.encode(await _toJson());
}
