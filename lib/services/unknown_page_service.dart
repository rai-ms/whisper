import 'package:flutter/cupertino.dart';
import '../utils/routes/route_name.dart';

class UnknownPageService {
  static checkAuthHomePage(BuildContext context, {bool isTrue = false}) {
    if (isTrue) {
      return;
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.loginView, (route) => false);
    }
  }
}
