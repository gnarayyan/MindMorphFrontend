import 'dart:convert';

class CertificateListModel {
  int courseId;
  String title;
  String courseThumbnailUrl;
  String certificateViewUrl;

  CertificateListModel({
    required this.courseId,
    required this.title,
    required this.courseThumbnailUrl,
    required this.certificateViewUrl,
  });

  factory CertificateListModel._fromJson(Map<String, dynamic> json) =>
      CertificateListModel(
        courseId: json["courseId"],
        title: json["title"],
        courseThumbnailUrl: json["courseThumbnailUrl"],
        certificateViewUrl: json["certificateViewUrl"],
      );

  static List<CertificateListModel> fromResponseBody(String str) =>
      List<CertificateListModel>.from(
          json.decode(str).map((x) => CertificateListModel._fromJson(x)));
}

// class CertificateResponse {
//   bool isFailure;
//   List<CertificateListModel> courses;
//   CertificateResponse({
//     required this.isFailure,
//     required this.courses,
//   });

//   factory CertificateResponse.fromResponse(Response response) {
//     if (response.statusCode != 200) {
//       return CertificateResponse(isFailure: true, courses: []);
//     }
//     final courses = List<CertificateListModel>.from(json
//         .decode(response.body)
//         .map((x) => CertificateListModel._fromJson(x)));
//     return CertificateResponse(isFailure: true, courses: courses);
//   }
// }
