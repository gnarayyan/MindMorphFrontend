import 'dart:convert';

// String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String message;
  UserDataModel userData;

  LoginResponseModel({
    required this.message,
    required this.userData,
  });

  factory LoginResponseModel._fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        userData: UserDataModel.fromJson(json["userData"]),
      );

  factory LoginResponseModel.fromResponseBody(String str) =>
      LoginResponseModel._fromJson(json.decode(str));

  // Map<String, dynamic> toJson() => {
  //     "message": message,
  //     "userData": userData.toJson(),
  // };
}

class UserDataModel {
  String fullName;
  String email;
  int userId;
  String avatar;
  String role;
  String token;
  bool? isLogin;

  UserDataModel({
    required this.fullName,
    required this.email,
    required this.userId,
    required this.avatar,
    required this.role,
    required this.token,
    isLogin,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        fullName: json["fullName"],
        email: json["email"],
        userId: json["userId"],
        avatar: json["avatar"],
        role: json["role"],
        token: json["token"],
        isLogin: json["isLogin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "userId": userId,
        "avatar": avatar,
        "role": role,
        "token": token,
        "isLogin": isLogin,
      };

  bool get isStudent {
    return role == 'STUDENT';
  }

  bool get isInstructor {
    return role == 'INSTRUCTOR';
  }

  bool get isAdmin {
    return role == 'ADMIN';
  }
}

// If response code != 200
class FailureLoginResponseModel {
  String message;

  FailureLoginResponseModel({required this.message});

  factory FailureLoginResponseModel._fromJson(Map<String, dynamic> json) =>
      FailureLoginResponseModel(message: json["message"]);

  factory FailureLoginResponseModel.fromResponseBody(String str) =>
      FailureLoginResponseModel._fromJson(json.decode(str));

  // Map<String, dynamic> toJson() => {
  //     "message": message
  // };
}
