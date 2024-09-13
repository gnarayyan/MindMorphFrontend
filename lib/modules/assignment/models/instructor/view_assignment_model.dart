// To parse this JSON data, do
//
//     final viewAssignmentModel = viewAssignmentModelFromJson(jsonString);

import 'dart:convert';

class ViewAssignmentModel {
  int id;
  int courseId;
  String title;
  String instruction;
  DateTime deadline;
  int points;
  String attachment;
  int instructorId;
  String createdAt;

  ViewAssignmentModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.instruction,
    required this.deadline,
    required this.points,
    required this.attachment,
    required this.instructorId,
    required this.createdAt,
  });

  factory ViewAssignmentModel._fromJson(Map<String, dynamic> json) =>
      ViewAssignmentModel(
        id: json["id"],
        courseId: json["courseId"],
        title: json["title"],
        instruction: json["instruction"],
        deadline: DateTime.parse(json["deadline"]),
        points: json["points"],
        attachment: json["attachment"],
        instructorId: json["instructorId"],
        createdAt: json["createdAt"],
      );
  factory ViewAssignmentModel.instanceFromResponseBody(String responseBody) =>
      ViewAssignmentModel._fromJson(json.decode(responseBody));

  static List<ViewAssignmentModel> fromResponseBody(String responseBody) =>
      List<ViewAssignmentModel>.from(json
          .decode(responseBody)
          .map((x) => ViewAssignmentModel._fromJson(x)));
}
