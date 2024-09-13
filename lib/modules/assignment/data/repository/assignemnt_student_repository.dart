import '../../models/instructor/create_response_model.dart';
import '../../models/student/submit_assignment_model.dart';
import '../../models/student/view_assignments_model.dart';
import '../../models/instructor/view_assignment_model.dart' as instructor;

import '../provider/assignemnt_student_provider.dart';

class AssignmentStudentRepository {
  static Future<ResponseModel> submitAssignment(
      SubmitAssignmentModel data) async {
    final response = await StudentAssignmentProvider.submitAssignment(data);

    return ResponseModel.fromResponse(response, createRequest: true);
  }

  // static Future<Map<String, String>> getInstructorCourses() async {
  //   final response = await InstructorAssignmentProvider.getInstructorCourses();

  //   final result = InstructorCoursesListModel.fromResponseBody(response.body);
  //   return result;
  // }

  static Future<ViewAssignmentModel> getAllAssignments() async {
    final response = await StudentAssignmentProvider.getAllAssignments();
    if (response.statusCode != 200) throw "Failed to fetch Assignments";

    final result = ViewAssignmentModel.fromResponseBody(response.body);
    return result;
  }

  static Future<instructor.ViewAssignmentModel> getAssignment(
      int assignmentId) async {
    final response =
        await StudentAssignmentProvider.getAssignment(assignmentId);
    if (response.statusCode != 200) throw "Failed to fetch Assignments";

    final result =
        instructor.ViewAssignmentModel.instanceFromResponseBody(response.body);
    return result;
  }

  // Update
  static Future<ResponseModel> updateAssignment(
      SubmitAssignmentModel data) async {
    final response = await StudentAssignmentProvider.updateAssignment(data);

    return ResponseModel.fromResponse(response);
  }

  // static Future<ResponseModel> deleteAssignment(int id) async {
  //   final response = await InstructorAssignmentProvider.deleteAssignment(id);

  //   final result = ResponseModel.fromResponse(response);
  //   return result;
  // }
}
