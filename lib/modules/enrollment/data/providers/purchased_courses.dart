import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class PurchasedCoursesProvider {
  static Future<http.Response> getAll() async {
    int userId = await UserStorage.userId;
    // print('User id: $userId');
    var uri = Uri.http(NODE_SERVER, '/enroll/all/$userId');

    final response = await http.get(uri);
    return response;
  }
}
