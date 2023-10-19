import 'package:flutter/material.dart';

import '../../utils/app_helper/user_data_prefrence/user_data.dart';

class GetProfileData extends ChangeNotifier
{
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
}