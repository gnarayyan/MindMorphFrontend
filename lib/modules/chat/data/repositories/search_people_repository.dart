import 'package:mindmorph/modules/chat/data/providers/search_people_provider.dart';
import '../../models/search_people_model.dart';

class SearchPeopleRepository {
  static Future<List<UserSearchResultModel>> searchPeople(
      String receiverName) async {
    final response = await SearchPeopleProvider.searchPeople(receiverName);

    final result = UserSearchResultModel.fromResponseBody(response.body);

    return result;
  }
}
