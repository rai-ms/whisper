import 'package:flutter/cupertino.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';
import 'package:whisper/utils/routes/route_name.dart';

class ForgetPasswordViewModel extends ChangeNotifier {
  TextEditingController mailCont = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey();
  bool loading = false;

  final LoginRepository _repo = LoginRepository();
  sendOTPForForgetPassword(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      try {
        await Future.delayed(const Duration(seconds: 2));
        _repo.forgetPasswordLoginAPI(
            {"email": mailCont.text.toString().trim()}).then((value) {
          debugPrint("OTP Sent Success $value");
          Navigator.pushNamed(context, RouteName.otpAuthView, arguments: {
            'mail': mailCont.text.toString().trim(),
            'password': "",
            'isForgetPass': true
          });
        }).onError((error, stackTrace) {
          debugPrint("Error in Forget Password: $error");
          return;
        });
        loading = false;
        notifyListeners();
      } catch (e) {
        debugPrint(e.toString());
      }
      // if(context.mounted)
      // {
      //
      // }
    }
  }

  @override
  void dispose() {
    mailCont.dispose();
    buttonFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
