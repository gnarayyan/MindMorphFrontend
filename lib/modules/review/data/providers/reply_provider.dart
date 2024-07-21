import 'package:http/http.dart' as http;
import '/constants/urls.dart';

class ReplyProvider {
  static Future<http.Response> addReply(String body) async {
    var uri = Uri.http(NODE_SERVER, '/reviews/reply');

    final response = await http.post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: body,
    );
    return response;
  }
}
