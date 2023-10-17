import 'package:flutter/material.dart';
import 'package:whisper/model/user_model.dart';
import '../utils/app_helper/user_data_prefrence/user_data.dart';
import '../utils/routes/route_name.dart';

class SplashScreenServices {
  static checkAuthentication(BuildContext context) async {
    UserModel user = await UserData.getUser();
    debugPrint(user.token);
    await Future.delayed(const Duration(seconds: 3));
    if(user.token == "null" || user.token!.isEmpty){
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(context, RouteName.introView, (route)=> false);
      }
    }
    else {
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(context, RouteName.homeView, (route)=> false);
      }
    }
  }
}
