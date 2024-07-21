import '../../models/conversations_model.dart';
import '../../models/messages_model.dart';
import '../providers/conversation_provider.dart';

class ConversationRepository {
  static Future<List<ConversationModel>> getConversations() async {
    final response = await ConversationProvider.getConversations();

    final result = ConversationModel.fromResponse(response.body);

    return result;
  }

  static Future<List<MessageModel>> getMessages(int conversationId) async {
    final response = await ConversationProvider.getMessages(conversationId);

    final result = MessageModel.fromResponseBody(response.body);

    return result;
  }
}
