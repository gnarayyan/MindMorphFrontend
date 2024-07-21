import 'dart:convert';
import 'course_data_model.dart';
import 'course_view_model.dart';

class CourseCarasoulData {
  Author author;
  double discountPercent;
  double rating;
  int id;
  double price;
  String courseThumbnailUrl;
  String title;
  CourseCarasoulData({
    required this.author,
    required this.courseThumbnailUrl,
    required this.discountPercent,
    required this.id,
    required this.price,
    required this.rating,
    required this.title,
  });

  static List<CourseCarasoulData> getCarasoulDataList(
      List<CourseViewModel> coursesView,
      Map<int, CourseDataModel> coursesData) {
    List<CourseCarasoulData> carasoulDataList = [];

    for (CourseViewModel course in coursesView) {
      // if (!coursesData.containsKey(course.id)) return [];
      CourseDataModel courseData = coursesData[course.id] ??
          CourseDataModel(
              courseId: course.id, courseThumbnailUrl: '', title: '');
      final carasoulData = CourseCarasoulData(
        author: course.author,
        courseThumbnailUrl: courseData.courseThumbnailUrl,
        discountPercent: course.discountPercent,
        id: course.id,
        price: course.price,
        rating: course.rating,
        title: courseData.title,
      );
      carasoulDataList.add(carasoulData);
    }
    return carasoulDataList;
  }

  // Added for recommed course
  static List<CourseCarasoulData> fromResponseBody(String str) =>
      List<CourseCarasoulData>.from(
          json.decode(str).map((x) => CourseCarasoulData._fromJson(x)));

  factory CourseCarasoulData._fromJson(Map<String, dynamic> json) =>
      CourseCarasoulData(
        title: json["title"],
        courseThumbnailUrl: json["courseThumbnailUrl"],
        id: json["id"],
        price: json["price"],
        discountPercent: json["discountPercent"],
        rating: json["rating"],
        author: Author.fromJson(json["author"]),
      );
}
