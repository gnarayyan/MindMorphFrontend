import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class CourseProvider {
  static Future<http.Response> getCourse(int courseId) async {
    final uri = Uri.http(NODE_SERVER, '/course/$courseId');

    try {
      final response = await http.get(uri);
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()} while fetching courseId: $courseId';
    }
  }

  static Future<http.Response> getCourseDetails(int courseId,
      {bool hasEnrolled = false}) async {
    final userId = await UserStorage.userId;
    final uri = hasEnrolled
        ? Uri.http(COURSE_SERVER, '/courses/$courseId', {'userId': '$userId'})
        : Uri.http(COURSE_SERVER, '/courses/$courseId');

    try {
      final response = await http.get(uri);
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()} while fetching courseId: $courseId';
    }
  }
}
