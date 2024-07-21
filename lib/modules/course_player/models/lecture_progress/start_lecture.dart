import 'dart:convert';

import 'package:http/http.dart';

class StartLectureModel {
  String message;
  LectureProgress? progress;
  bool isResume;

  StartLectureModel({
    required this.message,
    required this.isResume,
    this.progress,
  });

  factory StartLectureModel._fromJson(
      Map<String, dynamic> json, int statusCode) {
    if (statusCode == 409) {
      return StartLectureModel(
        message: json["message"],
        isResume: true,
        progress: LectureProgress.fromJson(json["progress"]),
      );
    }
    return StartLectureModel(message: json["message"], isResume: false);
  }
  static StartLectureModel fromResponse(Response response) =>
      StartLectureModel._fromJson(
          json.decode(response.body), response.statusCode);
}

class LectureProgress {
  String id;
  bool completed;
  String duration;

  LectureProgress({
    required this.id,
    required this.completed,
    required this.duration,
  });

  factory LectureProgress.fromJson(Map<String, dynamic> json) =>
      LectureProgress(
        id: json["_id"],
        completed: json["completed"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "completed": completed,
        "duration": duration,
      };
}
