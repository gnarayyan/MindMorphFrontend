import 'package:http/http.dart' as http;
import '/constants/urls.dart';

class SearchProvider {
  static Future<http.Response> search(String query) async {
    var uri = Uri.http(PYTHON_SERVER, '/search', {'q': query});

    final response = await http.get(uri);
    return response;
  }
}
