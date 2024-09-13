import '../../models/instructor/create_assignment_submission.dart';
import '../../models/instructor/create_response_model.dart';
import '../../models/instructor/instructor_course_list.dart';
import '../../models/instructor/view_assignment_model.dart';
import '../provider/assignemnt_instructor_provider.dart';

class AssignmentInstructorRepository {
  static Future<ResponseModel> createAssignment(
      CreateAssignmentSubmission data) async {
    final response = await InstructorAssignmentProvider.createAssignment(data);

    return ResponseModel.fromResponse(response, createRequest: true);
  }

  static Future<Map<String, String>> getInstructorCourses() async {
    final response = await InstructorAssignmentProvider.getInstructorCourses();

    final result = InstructorCoursesListModel.fromResponseBody(response.body);
    return result;
  }

  static Future<List<ViewAssignmentModel>> getCreatedAssignments() async {
    final response = await InstructorAssignmentProvider.getCreatedAssignments();
    if (response.statusCode != 200) throw "Failed to fetch Assignments";

    final result = ViewAssignmentModel.fromResponseBody(response.body);
    return result;
  }

  // Update
  static Future<ResponseModel> updateAssignment(
      CreateAssignmentSubmission data) async {
    final response = await InstructorAssignmentProvider.updateAssignment(data);

    return ResponseModel.fromResponse(response);
  }

  static Future<ResponseModel> deleteAssignment(int id) async {
    final response = await InstructorAssignmentProvider.deleteAssignment(id);

    final result = ResponseModel.fromResponse(response);
    return result;
  }
}
