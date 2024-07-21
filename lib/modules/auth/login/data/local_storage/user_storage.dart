// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants/urls.dart';
import '../../models/login_response_model.dart';

class UserStorage {
  static const _FULL_NAME = 'fullName';
  static const _EMAIL = 'email';
  static const _AVATAR = 'avatar';
  static const _USER_ID = 'userId';
  static const _IS_LOGIN = 'isLogin';
  static const _ROLE = 'role';
  static const _TOKEN = 'token';

  static Future<int> get userId async {
    final storage = await SharedPreferences.getInstance();
    return storage.getInt(_USER_ID) ?? -1;
  }

  static Future<UserDataModel> get user async {
    final storage = await SharedPreferences.getInstance();

    String fullName = storage.getString(_FULL_NAME) ?? '';
    String email = storage.getString(_EMAIL) ?? '';
    String avatar = '$NODE_SERVER/${storage.getString(_AVATAR)}';
    int userId = storage.getInt(_USER_ID) ?? -1;
    bool isLogin = storage.getBool(_IS_LOGIN) ?? false;
    String role = storage.getString(_ROLE) ?? 'STUDENT';
    String token = storage.getString(_TOKEN) ?? '';

    return UserDataModel(
      fullName: fullName,
      email: email,
      avatar: avatar,
      isLogin: isLogin,
      role: role,
      userId: userId,
      token: token,
    );
  }

  static save(UserDataModel userData) async {
    final storage = await SharedPreferences.getInstance();

    await storage.setString(_FULL_NAME, userData.fullName);
    await storage.setString(_EMAIL, userData.email);
    await storage.setString(_AVATAR, userData.avatar);
    await storage.setInt(_USER_ID, userData.userId);
    await storage.setBool(_IS_LOGIN, userData.isLogin ?? false);
    await storage.setString(_ROLE, userData.role);
    await storage.setString(_TOKEN, userData.token);
  }

  static logout() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(_FULL_NAME);
    await storage.remove(_EMAIL);
    await storage.remove(_AVATAR);
    await storage.remove(_USER_ID);
    await storage.remove(_IS_LOGIN);
    await storage.remove(_ROLE);
    await storage.remove(_TOKEN);
  }

  static Future<bool> isLogin() async {
    final storage = await SharedPreferences.getInstance();
    return storage.containsKey(_IS_LOGIN);
  }

  static Future<void> switchProfile() async {
    const instructor = 'INSTRUCTOR';
    const student = 'STUDENT';

    final storage = await SharedPreferences.getInstance();
    String? role = storage.getString(_ROLE);

    if (role == null) return;

    final roleData = role == student ? instructor : student;

    await storage.setString(_ROLE, roleData);
  }

  static Future<bool> get isStudent async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(_ROLE) == 'STUDENT';
  }

  static Future<bool> get isInstructor async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(_ROLE) == 'INSTRUCTOR';
  }

  static Future<bool> get isAdmin async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(_ROLE) == 'ADMIN';
  }
}
