import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mindmorph/constants/urls.dart';

class SwiperProvider {
  static Future<http.Response> uploadSwiper(String imagePath) async {
    final uri = Uri.http(NODE_SERVER, '/swiper');
    final header = {'Content-type': 'multipart/form-data'};

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imagePath,
      contentType: MediaType('image', 'jpeg'),
    ));

    final response = await http.Response.fromStream(await request.send());

    return response;
  }

  static Future<http.Response> getAllSwipers() async {
    final uri = Uri.http(NODE_SERVER, '/swiper');

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> deleteSwiper(int id) async {
    final uri = Uri.http(NODE_SERVER, '/swiper/$id');

    final response = await http.delete(uri);
    return response;
  }
}
