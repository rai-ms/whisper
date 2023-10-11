import 'package:flutter/material.dart';
import '../utils/routes/route_name.dart';

class SplashScreenServices {
  static checkAuthentication(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted){
      Navigator.pushNamedAndRemoveUntil(context, RouteName.introView, (route)=> false);
    }
  }
}
