import 'dart:convert';

class InstructorCoursesListModel {
  int courseId;
  String title;
  String courseThumbnailUrl;

  InstructorCoursesListModel({
    required this.courseId,
    required this.title,
    required this.courseThumbnailUrl,
  });

  factory InstructorCoursesListModel._fromJson(Map<String, dynamic> json) =>
      InstructorCoursesListModel(
        courseId: json["courseId"],
        title: json["title"],
        courseThumbnailUrl: json["courseThumbnailUrl"],
      );

  static Map<String, String> fromResponseBody(String responseBody) {
    final courses = List<InstructorCoursesListModel>.from(json
        .decode(responseBody)
        .map((x) => InstructorCoursesListModel._fromJson(x)));

    if (courses.isEmpty) {
      return {};
    }

    Map<String, String> data = {};
    for (final course in courses) {
      data['${course.courseId}'] = course.title;
    }
    return data;
  }
}
