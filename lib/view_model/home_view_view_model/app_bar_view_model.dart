import 'package:flutter/material.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/user_data/user_data.dart';
import 'package:whisper/utils/routes/route_name.dart';

class AppBarViewModel extends ChangeNotifier
{
  logoutUser(BuildContext context) async {
    // Api call for logout
    await UserData.removeUser().then((value) {
      CustomToast(context: context, message: AppStrings.logoutSuccess);
      Navigator.pushReplacementNamed(context, RouteName.loginView);
    }).onError((error, stackTrace) {
      debugPrint(AppStrings.error);
    });
  }
}