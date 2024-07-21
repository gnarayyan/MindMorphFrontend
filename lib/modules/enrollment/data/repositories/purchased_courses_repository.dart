import '../../../profile/data/repositories/course_initialize_submit_repository.dart';
import '../../../profile/models/instructor_course_list_course_server.dart';
import '../providers/purchased_courses.dart';

class PurchasedCoursesRepository {
  static Future<List<InstructorCourseModel>> getAll() async {
    final response = await PurchasedCoursesProvider.getAll();
    return InstructorCoursesRepository.coursesByIdsFromCourseServer(
        response.body);
    // '{"courseIds":[2,1,4,5,15,14,16]}');
  }
}
