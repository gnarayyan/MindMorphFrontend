import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import '../../models/instructor_course_list_course_server.dart';
import '../../models/courses_details.dart';
import '../providers/course_by_instructor.dart';

class InstructorCoursesRepository {
  static Future<List<InstructorCourseModel>> coursesByAuthorId() async {
    // Fetch UserId from local Storage
    final user = await UserStorage.user;

    // Node Server
    final response = await InstructorCourses.byInstructorId(user.userId);

    final courses = CourseByInstructorIdModel.fromResponse(response.body);

    final coursesWithPriceMap = CourseByInstructorIdModel.modelsToMap(courses);
    String requestBody =
        CourseByInstructorIdModel.modelsToJsonRequestBody(courses);
    final instructorCourses = await coursesByIdsFromCourseServer(requestBody);

    for (var i = 0; i < instructorCourses.length; i++) {
      final course = instructorCourses[i];
      instructorCourses[i].price = coursesWithPriceMap[course.courseId];
    }

    return instructorCourses;
  }

  static Future<List<InstructorCourseModel>> coursesByIdsFromCourseServer(
      String requestBody) async {
    try {
      // print('Req Body <${requestBody.runtimeType}>:   ${requestBody}');
      final coursesResponse = await InstructorCourses.byCoursesIds(requestBody);
      final courses = InstructorCourseModel.fromResponse(coursesResponse.body);
      // print('Courses: $courses');
      return courses;
    } catch (e) {
      // TODO
      rethrow;
    }

    // if (coursesResponse.statusCode != 200) {
    //   throw jsonDecode(coursesResponse.body);
    //   // return [];
    // }
  }
}
