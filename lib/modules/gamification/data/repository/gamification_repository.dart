import '../../../assignment/models/instructor/create_response_model.dart';
import '../../models/create_game_data.dart';
import '../../models/view_game_data.dart';
import '../provider/gamification_provider.dart';

class GamificationRepository {
  static Future<ResponseModel> createGameData(CreateGameModel data) async {
    final response = await GamificationProvider.addGamificationData(data);

    return ResponseModel.fromResponse(response, createRequest: true);
  }

  static Future<ViewGameModel> getGameData() async {
    final response = await GamificationProvider.getGameData();

    print('Result: ${response.body}');
    final result = ViewGameModel.fromResponseBody(response.body);
    return result;
  }

  // static Future<List<ViewAssignmentModel>> getCreatedAssignments() async {
  //   final response = await InstructorAssignmentProvider.getCreatedAssignments();
  //   if (response.statusCode != 200) throw "Failed to fetch Assignments";

  //   final result = ViewAssignmentModel.fromResponseBody(response.body);
  //   return result;
  // }

  // // Update
  // static Future<ResponseModel> updateAssignment(
  //     CreateAssignmentSubmission data) async {
  //   final response = await InstructorAssignmentProvider.updateAssignment(data);

  //   return ResponseModel.fromResponse(response);
  // }

  // static Future<ResponseModel> deleteAssignment(int id) async {
  //   final response = await InstructorAssignmentProvider.deleteAssignment(id);

  //   final result = ResponseModel.fromResponse(response);
  //   return result;
  // }
}
