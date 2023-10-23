import 'dart:convert'; // Import the dart:convert library to work with JSON.
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user.dart';

class UserData {

  static late UserData userdata;
  static SharedPreferences? _preferences;

  UserData._internal() {
    init();
  }

  factory UserData() {
    userdata = UserData._internal();
    return userdata;
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<String?> getUserAccessToken() async {
    final String? userDataString = _preferences?.getString('userData');
    return userDataString;
  }

  static Future<String?> getUserUsername() async {
    final String? userDataString = _preferences?.getString('username');
    return userDataString;
  }

  static Future<String?> getUserCreatedAt() async {
    final String? userDataString = _preferences?.getString('createdAt');
    return userDataString;
  }

  static Future<String?> getUserEmail() async {
    final String? userDataString = _preferences?.getString('email');
    return userDataString;
  }

  static Future<String?> getUserId() async {
    final String? userDataString = _preferences?.getString('_id');
    return userDataString;
  }

  static Future<bool> saveUser(User user) async {
    final Map<String, dynamic> userDataMap = user.toJson();
    final String userDataString = json.encode(userDataMap);
    // debugPrint("$userDataMap <- This data is going to store into this-> $userDataString");
    await _preferences?.setString('userData', user.accessToken).then((value){
      debugPrint("Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save data Error: $error");
      return false;
    });

    await _preferences?.setString('username', user.username).then((value){
      debugPrint("Username Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save Username data Error: $error");
      return false;
    });


    await _preferences?.setString('createdAt', user.createdAt).then((value){
      debugPrint("createdAt Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save createdAt data Error: $error");
      return false;
    });


    await _preferences?.setString('email', user.email).then((value){
      debugPrint("email Data saved: $value");
      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save email data Error: $error");
      return false;
    });

    await _preferences?.setString('_id', user.id).then((value){
      debugPrint("id Data saved: $value");

      return true;
    }).onError((error, stackTrace){
      debugPrint("Unable to save email data Error: $error");
      return false;
    });

    return false;
  }

  static Future<bool> removeUser() async {
    bool remove = true;
    await _preferences?.remove('userData').then((value){
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= false;
    });
    await _preferences?.remove('_id').then((value) {
      remove &= true;
    }).onError((error, stackTrace){remove &= false;});
    await _preferences?.remove('username').then((value) {
      remove &= true;
    }).onError((error, stackTrace){remove &= false;});
    await _preferences?.remove('email').then((value) {remove &= true;}).onError((error, stackTrace) {remove &= true;});
    await _preferences?.remove('createdAt').then((value) {remove &= true;}).onError((error, stackTrace) {remove &= true;});
    return remove;
  }
}
