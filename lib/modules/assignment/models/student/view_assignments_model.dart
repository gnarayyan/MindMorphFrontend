import 'dart:convert';

// String viewGameModelToJson(ViewAssignmentModel data) =>
//     json.encode(data.toJson());

class ViewAssignmentModel {
  List<Assignment> newAssignments;
  List<Assignment> dueAssignments;
  List<Assignment> returnedAssignments;
  List<Assignment> pendingAssignments;

  ViewAssignmentModel({
    required this.newAssignments,
    required this.dueAssignments,
    required this.returnedAssignments,
    required this.pendingAssignments,
  });

  factory ViewAssignmentModel.fromJson(Map<String, dynamic> json) =>
      ViewAssignmentModel(
        newAssignments: List<Assignment>.from(
            json["newAssignments"].map((x) => Assignment.fromJson(x))),
        dueAssignments: List<Assignment>.from(
            json["dueAssignments"].map((x) => Assignment.fromJson(x))),
        returnedAssignments: List<Assignment>.from(
            json["returnedAssignments"].map((x) => Assignment.fromJson(x))),
        pendingAssignments: List<Assignment>.from(
            json["pendingAssignments"].map((x) => Assignment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "newAssignments": List<dynamic>.from(newAssignments.map((x) => x)),
        "dueAssignments":
            List<dynamic>.from(dueAssignments.map((x) => x.toJson())),
        "returnedAssignments":
            List<dynamic>.from(returnedAssignments.map((x) => x)),
        "pendingAssignments":
            List<dynamic>.from(pendingAssignments.map((x) => x)),
      };

  factory ViewAssignmentModel.fromResponseBody(String str) =>
      ViewAssignmentModel.fromJson(json.decode(str));
}

class Assignment {
  int id;
  String title;
  String deadline;
  User user;

  Assignment(
      {required this.id,
      required this.title,
      required this.deadline,
      required this.user});

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        title: json["title"],
        deadline: json["deadline"],
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "deadline": deadline,
        "User": user.toJson(),
      };
}

class User {
  String avatar;

  User({
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
      };
}
