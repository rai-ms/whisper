import 'package:flutter/material.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class GetProfileData extends ChangeNotifier {
  String? accessToken;
  String? username;
  String? createdAt;

  Future<String?> getUsername() async {
    return username ?? await UserData.getUserUsername();
  }

  Future<String?> getAccessToken() async {
    return accessToken ?? await UserData.getUserAccessToken();
  }

  Future<String?> getJoinedDate() async {
    return createdAt ?? await UserData.getUserCreatedAt();
  }

  Future<String?> getBio() async {
    return createdAt ?? await UserData.getBio();
  }

  Future<String?> getFullName() async {
    return createdAt ?? await UserData.getFullName();
  }

  Future<String?> getProfilePic() async {
    return createdAt ?? await UserData.getProfilePic();
  }

  Future loadAllDataWithProfilePic() async {
    String? data;
    await getProfilePic();
    await getAccessToken();
    await getJoinedDate();
    await getBio();
    data = await getUsername();
    await getFullName();
    return data;
  }
}
