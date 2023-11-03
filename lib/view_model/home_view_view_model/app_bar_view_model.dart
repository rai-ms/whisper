import 'package:flutter/material.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/routes/route_name.dart';

import '../../utils/app_helper/user_data_preferences/user_data.dart';

class AppBarViewModel extends ChangeNotifier {
  logoutUser(BuildContext context) async {
    // Api call for logout
    await UserData.removeUser().then((value) {
      /// [pageViewNumber] is to set as zero, so that user may re-login and will land on home page
      pageViewNumber = 0;
      CustomToast(context: context, message: AppStrings.logoutSuccess);
      Navigator.pushReplacementNamed(context, RouteName.loginView);
    }).onError((error, stackTrace) {
      debugPrint(AppStrings.error);
    });
  }
}
