import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

class CreateAssignmentSubmission {
  String title;
  String instruction;
  double points;
  String deadline;
  int courseId;
  File? file;
  int? id;
  CreateAssignmentSubmission(
      {required this.title,
      required this.instruction,
      required this.points,
      required this.deadline,
      required this.courseId,
      required this.file,
      this.id});

  Future<Map<String, String>> get createFields async {
    final userId = await UserStorage.userId;
    return {
      'courseId': courseId.toString(),
      'title': title,
      'instruction': instruction,
      'deadline': deadline,
      'points': points.toString(),
      'instructorId': userId.toString(),
    };
  }

  Map<String, String> get updateFields {
    return {
      'courseId': courseId.toString(),
      'title': title,
      'instruction': instruction,
      'deadline': deadline,
      'points': points.toString(),
      'id': id!.toString()
    };
  }

  Future<List<http.MultipartFile>> get files async {
    // print('FilePath: ${file.path}');
    if (file == null) throw 'Attachment doens\'t Exist';
    return [
      await http.MultipartFile.fromPath('file', file!.path,
          contentType: MediaType.parse('application/pdf')),
    ];
  }

// To update
  String toJsonBody() {
    // final userId = await UserStorage.userId;
    Map<String, dynamic> data = {
      'courseId': courseId,
      'title': title,
      'instruction': instruction,
      'deadline': deadline,
      'points': points,
      // 'instructorId': userId,
      'id': id
    };

    return jsonEncode(data);
  }
}
