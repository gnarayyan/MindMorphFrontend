import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../data/repositories/search_people_repository.dart';
import '../../models/search_people_model.dart';
import 'search_results.dart';

class LoadSearchResult extends StatelessWidget {
  const LoadSearchResult({super.key, required this.receiverNameQuery});
  final String receiverNameQuery;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserSearchResultModel>>(
      future: SearchPeopleRepository.searchPeople(receiverNameQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MindMorphLoadingIndicator();
        } else if (snapshot.hasError) {
          return const ErrorPage(message: 'Error while searching');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const ErrorPage(message: 'No data available');
        } else {
          final users = snapshot.data!;

          return SearchResults(users: users);
        }
      },
    );
  }
}
