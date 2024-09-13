import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';

import '../../models/instructor/create_assignment_submission.dart';

class InstructorAssignmentProvider {
  static Future<http.Response> createAssignment(
      CreateAssignmentSubmission data) async {
    final uri = Uri.http(NODE_SERVER, '/assignment/instructor');
    final header = {'Content-type': 'multipart/form-data'};

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(header);
    request.fields.addAll(await data.createFields); // assign a map here
    request.files.addAll(await data.files);

    final response = await http.Response.fromStream(await request.send());

    return response;
  }

  static Future<http.Response> getInstructorCourses() async {
    final userId = await UserStorage.userId;
    final uri = Uri.http(
        PYTHON_SERVER, '/instructor/courses/', {'id': userId.toString()});

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getCreatedAssignments() async {
    final userId = await UserStorage.userId;
    final uri = Uri.http(NODE_SERVER, '/assignment/instructor/$userId');

    final response = await http.get(uri);
    return response;
  }

  //Update
  static Future<http.Response> updateAssignment(
      CreateAssignmentSubmission data) async {
    final uri = Uri.http(NODE_SERVER, '/assignment/instructor');
    Map<String, String> header;
    http.Response response;

    if (data.file == null) {
      header = {'Content-type': 'application/json'};

      final response = await http.patch(
        uri,
        headers: header,
        body: data.toJsonBody(),
      );

      return response;
    }

    header = {'Content-type': 'multipart/form-data'};

    final request = http.MultipartRequest('PATCH', uri);
    request.headers.addAll(header);
    request.fields.addAll(data.updateFields);
    request.files.addAll(await data.files);

    response = await http.Response.fromStream(await request.send());

    return response;
  }

  static Future<http.Response> deleteAssignment(int id) async {
    final uri = Uri.http(NODE_SERVER, '/assignment/instructor/$id');

    final response = await http.delete(uri);
    return response;
  }
}
