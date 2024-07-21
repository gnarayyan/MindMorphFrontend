import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UserSignupModel {
  String fullName, email, password, role, birthdate, avatarName;
  File avatar;
  UserSignupModel(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.role,
      required this.birthdate,
      required this.avatar,
      required this.avatarName});
}

class SignupResponse {
  int? status;
  String message;
  SignupResponse({this.status, required this.message});
}

class SignupFormModel {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final role = TextEditingController(text: 'STUDENT');
  final birthdate = TextEditingController();
  File? avatar;

  SignupFormModel();

  UserSignupModel get data {
    return UserSignupModel(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        role: role.text.toUpperCase(),
        birthdate: birthdate.text,
        avatar: avatar!,
        avatarName: basename(avatar!.path));
  }
}
