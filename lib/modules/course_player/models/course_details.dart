// To parse this JSON data, do
//
//     final courseDetailsModel = courseDetailsModelFromJson(jsonString);

import 'dart:convert';

class CourseDetailsModel {
  int courseId;
  String title;
  String description;
  String objective;
  String requirement;
  String titleVideoUrl;
  String courseThumbnailUrl;
  double? courseCompleted;

  CourseDetailsModel(
      {required this.courseId,
      required this.title,
      required this.description,
      required this.objective,
      required this.requirement,
      required this.titleVideoUrl,
      required this.courseThumbnailUrl,
      this.courseCompleted});

  factory CourseDetailsModel._fromJson(Map<String, dynamic> json) =>
      CourseDetailsModel(
        courseId: json["courseId"],
        title: json["title"],
        description: json["description"],
        objective: json["objective"],
        requirement: json["requirement"],
        titleVideoUrl: json["titleVideoUrl"],
        courseThumbnailUrl: json["courseThumbnailUrl"],
        courseCompleted: (json['courseCompleted'] == null)
            ? 0
            : (100 * json['courseCompleted']) / 100,
      );

  factory CourseDetailsModel.fromResponseBody(String str) =>
      CourseDetailsModel._fromJson(json.decode(str));
}
