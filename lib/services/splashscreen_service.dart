import 'package:flutter/material.dart';
import '../utils/routes/route_name.dart';

class SplashScreenServices {
  static checkAuthentication(BuildContext context, {bool isTrue = true}) async {
    if (isTrue) {
      await Future.delayed(const Duration(milliseconds: 2100));
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeView, (route) => false);
    } else {
      await Future.delayed(const Duration(milliseconds: 2100));
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.introView, (route) => false);
    }
  }
}
