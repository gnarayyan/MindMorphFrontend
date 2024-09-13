// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

class SubmitAssignmentModel {
  int assignmentId;
  String comment;
  File? attachment;
  int? id;
  SubmitAssignmentModel({
    this.id,
    required this.assignmentId,
    required this.comment,
    required this.attachment,
  });

  Future<Map<String, String>> get createFields async {
    final userId = await UserStorage.userId;
    return {
      'studentId': userId.toString(),
      'comment': comment,
      'assignmentId': assignmentId.toString(),
    };
  }

  Future<List<http.MultipartFile>> get files async {
    if (attachment == null) throw 'Attachment doens\'t Exist';
    return [
      await http.MultipartFile.fromPath('file', attachment!.path,
          contentType: MediaType.parse('application/pdf')),
    ];
  }

// To update
  Future<Map<String, String>> get updateFields async {
    final userId = await UserStorage.userId;
    return {
      'studentId': userId.toString(),
      'comment': comment,
      'assignmentId': assignmentId.toString(),
      'id': id.toString()
    };
  }

  Future<String> toJsonBody() async {
    final userId = await UserStorage.userId;
    Map<String, dynamic> data = {
      'studentId': userId.toString(),
      'comment': comment,
      'assignmentId': assignmentId.toString(),
      'id': id
    };

    return jsonEncode(data);
  }
}
