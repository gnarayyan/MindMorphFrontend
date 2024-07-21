import 'dart:convert';

import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

class CreateReviewReplyModel {
  int courseId;
  int reviewId;
  String content;

  CreateReviewReplyModel({
    required this.courseId,
    required this.reviewId,
    required this.content,
  });
  Future<Map<String, dynamic>> _toJson() async => {
        "courseId": courseId,
        "reviewId": reviewId,
        "userId": await UserStorage.userId,
        "content": content,
      };

  Future<String> toRequestBody() async => json.encode(await _toJson());
}
