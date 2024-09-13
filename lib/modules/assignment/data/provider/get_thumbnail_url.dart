import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindmorph/constants/urls.dart';

Future<String> getThumbnailUrl(int courseId) async {
  final uri = Uri.http(
      PYTHON_SERVER, '/course/thumbnail/', {'courseId': courseId.toString()});

  final response = await http.get(uri);

  final url = json.decode(response.body)["courseThumbnailUrl"];
  return url;
}
