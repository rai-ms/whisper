import 'dart:convert'; // Import the dart:convert library to work with JSON.

import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user.dart';

class UserData {

  static Future<User?> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataString = preferences.getString('userData');

    if (userDataString != null) {
      final Map<String, dynamic> userDataMap = json.decode(userDataString);
      return User.fromJson(userDataMap);
    } else {
      return null;
    }
  }

  static Future<bool> saveUser(User user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> userDataMap = user.toJson();
    final String userDataString = json.encode(userDataMap);
    return await preferences.setString('userData', userDataString);
  }

  static Future<bool> removeUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove('userData');
  }
}
