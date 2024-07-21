import 'package:mindmorph/modules/search/models/search_response.dart';
import '../providers/search_provider.dart';

class SearchRepository {
  static Future<SearchResultModel> search(String query) async {
    // Node Server
    final response = await SearchProvider.search(query);

    final courses = SearchResultModel.fromResponse(response);
    return courses;
  }
}
