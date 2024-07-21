import 'dart:convert';

class UserSearchResultModel {
  int id;
  String fullName;
  String avatar;

  UserSearchResultModel({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  factory UserSearchResultModel._fromJson(Map<String, dynamic> json) =>
      UserSearchResultModel(
        id: json["id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
      );

  static List<UserSearchResultModel> fromResponseBody(String str) =>
      List<UserSearchResultModel>.from(
          json.decode(str).map((x) => UserSearchResultModel._fromJson(x)));
}
