import 'package:flutter/material.dart';
import '../utils/app_helper/user_data_preferences/user_data.dart';
import '../utils/routes/route_name.dart';

class SplashScreenServices {
  static checkAuthentication(BuildContext context) async {
    String? user = await UserData.getUserAccessToken();
    // String? id = await UserData.getUserId();
    // debugPrint("UserId: $id");
    await Future.delayed(const Duration(seconds: 3));
    if (user == "null" || user == null) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.introView, (route) => false);
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.homeView, (route) => false);
      }
    }
  }
}
