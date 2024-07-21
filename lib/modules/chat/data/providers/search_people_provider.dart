import 'package:http/http.dart' as http;

import '/constants/urls.dart';

class SearchPeopleProvider {
  static Future<http.Response> searchPeople(String receiverName) async {
    var uri = Uri.http(NODE_SERVER, '/search/users', {'q': receiverName});

    final response = await http.get(uri);
    return response;
  }
}
