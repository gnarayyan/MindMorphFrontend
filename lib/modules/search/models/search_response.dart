// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:http/http.dart';

class SearchModel {
  int courseId;
  String title;
  String courseThumbnailUrl;

  SearchModel({
    required this.courseId,
    required this.title,
    required this.courseThumbnailUrl,
  });

  factory SearchModel._fromJson(Map<String, dynamic> json) => SearchModel(
        courseId: json["courseId"],
        title: json["title"],
        courseThumbnailUrl: json["courseThumbnailUrl"],
      );

  static List<SearchModel> fromResponseBody(String str) =>
      List<SearchModel>.from(
          json.decode(str).map((x) => SearchModel._fromJson(x)));
}

class SearchResultModel {
  bool isFailure;
  List<SearchModel> courses;
  SearchResultModel({
    required this.isFailure,
    required this.courses,
  });

  factory SearchResultModel.fromResponse(Response response) {
    if (response.statusCode == 200) {
      final courses = SearchModel.fromResponseBody(response.body);
      if (courses.isNotEmpty) {
        return SearchResultModel(isFailure: false, courses: courses);
      }
    }
    return SearchResultModel(isFailure: true, courses: []);
  }
}
