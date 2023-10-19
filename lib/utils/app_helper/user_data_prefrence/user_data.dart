import 'dart:convert'; // Import the dart:convert library to work with JSON.

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user.dart';

class UserData {

  static Future<String?> getUserAccessToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataString = preferences.getString('userData');
    return userDataString;
  }

  static Future<String?> getUserUsername() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataString = preferences.getString('username');
    return userDataString;
  }

  static Future<String?> getUserCreatedAt() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataString = preferences.getString('createdAt');
    return userDataString;
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataString = preferences.getString('email');
    return userDataString;
  }


  static Future<bool> saveUser(User user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> userDataMap = user.toJson();
    final String userDataString = json.encode(userDataMap);
    // debugPrint("$userDataMap <- This data is going to store into this-> $userDataString");

    await preferences.setString('userData', user.accessToken).then((value){
      debugPrint("Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save data Error: $error");
      return false;
    });

    await preferences.setString('username', user.username).then((value){
      debugPrint("Username Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save Username data Error: $error");
      return false;
    });


    await preferences.setString('createdAt', user.createdAt).then((value){
      debugPrint("createdAt Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save createdAt data Error: $error");
      return false;
    });


    await preferences.setString('email', user.email).then((value){
      debugPrint("email Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save email data Error: $error");
      return false;
    });
    return false;
  }

  static Future<bool> removeUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool remove = true;
    remove &= await preferences.remove('userData');
    remove &= await preferences.remove('username');
    remove &= await preferences.remove('email');
    remove &= await preferences.remove('createdAt');
    return remove;
  }
}
