// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/course_carasoul_data_model.dart';
import '../../models/course_data_model.dart';
import '../../models/course_view_model.dart';
import '../providers/course_view_provider.dart';

class CourseViewRepository {
  // Get Course Thumbanails and Title
  static Future<Map<int, CourseDataModel>> _getThumbnailsAndTitle(
      String requestBody) async {
    final response = await CourseViewProvider.thumbnailsAndTitles(requestBody);
    final coursesData = CourseDataModel.fromResponseBody(response.body);

    return coursesData;
  }

  //Get Trending Courses
  static Future<List<CourseCarasoulData>> trendingCourses() async {
    final response = await CourseViewProvider.trendingCourses();
    final coursesView = CourseViewModel.fromResponseBody(response.body);

    //courseId List
    String requestBody = CourseViewModel.getIdsJsonList(coursesView);
    final coursesData = await _getThumbnailsAndTitle(requestBody);

    final coursesCarasoulData =
        CourseCarasoulData.getCarasoulDataList(coursesView, coursesData);

    return coursesCarasoulData;
  }

  //Get New/Latest Courses
  static Future<List<CourseCarasoulData>> newCourses() async {
    final response = await CourseViewProvider.newCourses();
    final coursesView = CourseViewModel.fromResponseBody(response.body);

    //courseId List
    String requestBody = CourseViewModel.getIdsJsonList(coursesView);
    final coursesData = await _getThumbnailsAndTitle(requestBody);

    final coursesCarasoulData =
        CourseCarasoulData.getCarasoulDataList(coursesView, coursesData);

    return coursesCarasoulData;
  }

  //Recommended Courses
  static Future<List<CourseCarasoulData>> recommendedCourses() async {
    final response = await CourseViewProvider.recommendedCourses();

    if (response.statusCode != 200) {
      return [];
    }

    return CourseCarasoulData.fromResponseBody(response.body);
  }
}
