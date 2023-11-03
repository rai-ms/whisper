import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';

import '../../global/global.dart';
import '../../res/components/custom_toast.dart';
import '../../utils/app_helper/app_strings.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';
import '../../utils/routes/route_name.dart';

class SettingsViewModel extends ChangeNotifier {
  var repo = LoginRepository();
  Future logoutUser(BuildContext context) async {
    // Api call for logout
    await repo.logoutUser().then((value) async {
      if (value == true) {
        await UserData.removeUser().then((values) {
          /// [pageViewNumber] is to set as zero, so that user may re-login and will land on home page
          pageViewNumber = 0;
          CustomToast(
              context: context,
              message: "${AppStrings.logoutSuccess} : $value");
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.loginView, (route) => false);
        }).onError((error, stackTrace) {
          debugPrint(AppStrings.error);
          throw AppError(error.toString());
        });
      } else {
        debugPrint("Error");
      }
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
  }
}
