import 'package:mindmorph/modules/cart/models/response_model.dart';

import '../../models/lecture_progress/start_lecture.dart';
import '../providers/lecture_progress.dart';

class LectureProgressRepository {
  static Future<StartLectureModel> startLecture(String lectureId) async {
    final response = await LectureProgressProvider.startLecture(lectureId);
    final progress = StartLectureModel.fromResponse(response);
    return progress;
  }

  static Future<ResponseModel> saveProgress(
      Map<String, dynamic> updateData) async {
    final response = await LectureProgressProvider.saveProgress(updateData);
    final result = ResponseModel.fromResponse(response);
    return result;
  }
}
