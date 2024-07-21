import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class LectureProgressProvider {
  static Future<http.Response> startLecture(String lectureId) async {
    final userId = await UserStorage.userId;
    final requestBody = jsonEncode({"userId": userId, "lectureId": lectureId});

    final uri = Uri.http(COURSE_SERVER, '/progress');

    try {
      final response = await http.post(
        uri,
        headers: {'Content-type': 'application/json'},
        body: requestBody,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> saveProgress(
      Map<String, dynamic> updateData) async {
    final userId = await UserStorage.userId;
    final requestBody = jsonEncode({"userId": userId, ...updateData});

    final uri = Uri.http(COURSE_SERVER, '/progress');

    try {
      final response = await http.patch(
        uri,
        headers: {'Content-type': 'application/json'},
        body: requestBody,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
