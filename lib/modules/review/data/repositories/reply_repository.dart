import '../../models/create_response_model.dart';
import '../../models/get_all_review_model.dart';
import '../providers/reply_provider.dart';

class ReplyRepository {
  static Future<ResponseModel<Reply>> addReply(String body) async {
    final response = await ReplyProvider.addReply(body);

    ResponseModel<Reply> result =
        ResponseModel.fromResponse(response, Reply.fromJson);

    return result;
  }
}
