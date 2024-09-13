import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

import '../../models/create_game_data.dart';

//
class GamificationProvider {
  static Future<http.Response> addGamificationData(CreateGameModel data) async {
    final uri = Uri.http(NODE_SERVER, '/game');
    Map<String, String> header;
    http.Response response;

    if (data.image == null) {
      header = {'Content-type': 'application/json'};

      final response = await http.post(
        uri,
        headers: header,
        body: data.toJsonBody(),
      );

      return response;
    }

    header = {'Content-type': 'multipart/form-data'};

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(header);
    request.fields.addAll(data.createFields); // assign a map here
    request.files.addAll(await data.files);

    response = await http.Response.fromStream(await request.send());

    return response;
  }

  static Future<List<Map<String, String>>> fetchTips() async {
    final uri = Uri.http(NODE_SERVER, '/game');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data.map<Map<String, String>>((item) {
          if (item is Map<String, dynamic>) {
            return {
              'title': item['title'],
              'image': item['image'],
            };
          } else {
            throw Exception('Unexpected item format');
          }
        }).toList();
      } else if (data is Map<String, dynamic>) {
        return [
          {
            'title': data['title'],
            'image': data['image'],
          }
        ];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load tips: ${response.statusCode}');
    }
  }

  static Future<http.Response> getGameData() async {
    int userId = await UserStorage.userId;
    final uri = Uri.http(NODE_SERVER, '/game/$userId');

    final response = await http.get(uri);
    return response;
  }

  // static Future<http.Response> deleteSwiper(int id) async {
  //   final uri = Uri.http(NODE_SERVER, '/swiper/$id');

  //   final response = await http.delete(uri);
  //   return response;
  // }
}
