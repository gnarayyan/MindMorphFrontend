import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class CourseViewProvider {
  static String quantityFeatchPerCarasoul = '3';

  static Future<http.Response> thumbnailsAndTitles(String requestBody) async {
    final uri = Uri.http(COURSE_SERVER, '/courses/titleAndThumbnail');

    try {
      final response = await http.post(uri,
          headers: {'Content-type': 'application/json'}, body: requestBody);

      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()}';
    }
  }

  static Future<http.Response> trendingCourses() async {
    int userId = await UserStorage.userId;
    final uri = Uri.http(NODE_SERVER, '/course/trending',
        {'qty': quantityFeatchPerCarasoul, 'userId': userId.toString()});

    try {
      final response = await http.get(uri);
      // if (response.statusCode != 200) throw 'Failed to Fetch Trending Courses';
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()}';
    }
  }

  static Future<http.Response> newCourses() async {
    int userId = await UserStorage.userId;
    final uri = Uri.http(NODE_SERVER, '/course/latest',
        {'qty': quantityFeatchPerCarasoul, 'userId': userId.toString()});

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) throw 'Failed to Fetch New Courses';
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()}';
    }
  }

  static Future<http.Response> recommendedCourses() async {
    int userId = await UserStorage.userId;
    final uri = Uri.http(
      PYTHON_SERVER,
      '/recommendation/$userId',
      {'count': quantityFeatchPerCarasoul},
    );

    return await http.get(uri);

    // try {
    //   final response = await http.get(uri);
    //   if (response.statusCode == 403) {
    //     throw 'Enroll some courses to get recommend';
    //   }
    //   return response;
    // } catch (e) {
    //   rethrow;
    // }
  }
}
