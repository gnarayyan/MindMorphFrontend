import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class ReviewProvider {
  static Future<http.Response> getAllReviews(int courseId) async {
    int userId = await UserStorage.userId;
    var uri = Uri.http(NODE_SERVER, '/reviews/$courseId/$userId');

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> addReview(String body) async {
    var uri = Uri.http(NODE_SERVER, '/reviews');

    final response = await http.post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: body,
    );
    return response;
  }
}
