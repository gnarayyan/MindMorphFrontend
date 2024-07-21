import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '../../../enrollment/data/providers/purchased_courses.dart';
import '/constants/urls.dart';

class CertificateProvider {
  static Future<http.Response> getEligibleCourses() async {
    final user = await UserStorage.user;

    final enrolledCourses = await PurchasedCoursesProvider.getAll();
    final jsonData = jsonDecode(enrolledCourses.body);
    final requestData = {
      'courseIds': jsonData['courseIds'],
      'user': {'fullName': user.fullName, 'userId': user.userId}
    };

    // print('Request Data: $requestData');
    final jsonBody = jsonEncode(requestData);
    final uri = Uri.http(COURSE_SERVER, '/certificate');

    final response = await http.post(uri,
        headers: {'Content-type': 'application/json'}, body: jsonBody);
    // print('response: ${response.body}');
    return response;
  }
}
