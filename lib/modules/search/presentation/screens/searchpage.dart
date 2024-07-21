import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mindmorph/modules/search/data/repositories/search_repository.dart';
import 'package:mindmorph/modules/search/models/search_response.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import '../search_view.dart';
import '/constants/color.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? searchValue = '';
  // final List<String> _suggestions = [
  //   'Flutter',
  //   'Android',
  //   'nodejs',
  //   'java script'
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: boxcolor,
      appBar: EasySearchBar(
        searchBackgroundColor: boxcolor,
        searchCursorColor: featureColor,
        showClearSearchIcon: true,
        title: const Text(
          'Search.....',
          style: TextStyle(color: featureColor),
        ),
        titleTextStyle: const TextStyle(fontSize: 25),
        backgroundColor: boxcolor,
        onSearch: (value) => setState(() => searchValue = value),
      ),
      // suggestions: _suggestions),
      body: searchValue == ''
          ? const ErrorPage(message: 'Enter Query to Search')
          : FutureBuilder<SearchResultModel>(
              future: SearchRepository.search(searchValue!.trim()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MindMorphLoadingIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const ErrorPage(message: 'No data available');
                } else {
                  final courses = snapshot.data!;

                  return courses.isFailure
                      ? const ErrorPage(message: 'No result found')
                      : SearchView(courses: courses.courses);
                }
              },
            ),
    );
  }
}
