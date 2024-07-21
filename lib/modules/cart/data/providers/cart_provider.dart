import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class CartProvider {
  static Future<http.Response> addToCart(String requestBody) async {
    final uri = Uri.http(NODE_SERVER, '/cart');

    try {
      final response = await http.post(uri,
          headers: {'Content-type': 'application/json'}, body: requestBody);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> getAllCartItems() async {
    final userId = await UserStorage.userId;

    final uri = Uri.http(NODE_SERVER, '/cart/$userId');

    try {
      final response = await http.get(uri);
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()}';
    }
  }

  static Future<http.Response> deleteCartItem(int cartId) async {
    final uri = Uri.http(NODE_SERVER, '/cart/$cartId');

    try {
      final response = await http.delete(uri);
      return response;
    } catch (e) {
      throw 'Failed on Connecting to Server: ${e.toString()}';
    }
  }
}
