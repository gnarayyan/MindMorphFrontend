import 'package:http/http.dart' as http;
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '/constants/urls.dart';

class ConversationProvider {
  static Future<http.Response> getConversations() async {
    int userId = await UserStorage.userId;
    var uri = Uri.http(NODE_SERVER, '/chat/conversation/$userId');

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getMessages(int conversationId) async {
    var uri = Uri.http(NODE_SERVER, '/chat/messages/$conversationId');

    final response = await http.get(uri);
    return response;
  }
}
