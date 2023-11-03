import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';
import 'package:whisper/repository/signup_repo/signup_repository.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/app_color.dart';

import '../../components/app_text_form_field.dart';
import '../../global/global.dart';
import '../../res/components/app_rounded_button.dart';
import '../../utils/routes/route_name.dart';

class OTPAuthViewModel extends ChangeNotifier {
  int sec = 60;
  bool enableButton = false;
  Timer? timer;
  bool _isValidOTP = true;

  TextEditingController passResetCont = TextEditingController();
  TextEditingController confPassResetCont = TextEditingController();

  bool get isValidOTP => _isValidOTP;

  set isValidOTP(bool val) {
    _isValidOTP = val;
    notifyListeners();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1));
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if(sec == 0 || sec <= 0) {
    //     debugPrint(sec.toString());
    //     cancelTimer();
    //     enableButton = true;
    //     sec = 60;
    //   }
    //   else {
    //     if(sec <= 1){
    //       enableButton = true;
    //     }
    //     sec--;
    //   }
    //   debugPrint(enableButton.toString());
    //   notifyListeners();
    //
    // });
  }

  void cancelTimer() {
    //   // timer!.cancel();
  }

  String? otp;

  /// Api Call
  /// if Success and [isForgetPass] is true then will navigate to reset password otherwise navigate to Home Page with login
  void sendOTPForVerification({
    required bool isForgetPass,
    required String email,
    String? pass,
    required BuildContext context,
  }) async {
    debugPrint("OTP received: $otp");
    isValidOTP = true;
    notifyListeners();
    debugPrint("OTP received: $otp");
    if (!isForgetPass) {
      SignUpRepository signupRepo = SignUpRepository();
      signupRepo.verifyOTP(email, otp!).then((value) {
        debugPrint("Verification Success $value");
        Navigator.pushNamed(context, RouteName.loginView);
      }).onError((error, errorStack) {
        debugPrint("Verification Failed $error");
      });
    } else {
      // Forget Password Code will be here
      LoginRepository().forgetPasswordVerifyOTPLoginAPI(
          {"email": email, "otp": otp}).then((otpRes) {
        debugPrint("OTP Matching result received");
        if (otpRes == null ||
            otpRes['statusCode'] == null ||
            otpRes['statusCode'].toString().isEmpty ||
            otpRes['statusCode'].toString() == "null") {
          debugPrint("Failed OTP Match");
          return;
        }
        String token = otpRes['data']['resetPasswordToken'] ?? "";
        debugPrint("Token is $token");
        tokenReset = token;
        showBottomSheetForPasswordReset(
            token: token, email: email, context: context);
        // Navigator.pushNamedAndRemoveUntil(context, RouteName.loginView, (route) => false);
      }).onError((error, stackTrace) {});
    }
    // cancelTimer();
  }

  String tokenReset = "";
  resendOTP(String email) async {
    // enableButton = false;
    // sec = 60;
    // startTimer();
    await LoginRepository()
        .resendPassword({'email': email})
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  @override
  void dispose() {
    // cancelTimer();
    passResetCont.dispose();
    confPassResetCont.dispose();
    super.dispose();
  }

  showBottomSheetForPasswordReset(
      {required String email,
      required String token,
      required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                sizedBox(hei: 50),
                Text("Now You can reset password for the mail $email"),
                sizedBox(hei: 20),
                AppTextFormField(
                  cont: passResetCont,
                  prefixIcon: const Icon(Icons.lock_open),
                  hintText: "Enter Password",
                  obscureText: false,
                ),
                sizedBox(
                  hei: 20,
                ),
                AppTextFormField(
                  cont: confPassResetCont,
                  prefixIcon: const Icon(Icons.lock_open),
                  hintText: "Confirm Password",
                  obscureText: false,
                ),
                sizedBox(
                  hei: 20,
                ),
                AppRoundedButton(
                  onTap: () {
                    apiCall(context);
                  },
                  title: "Reset",
                  isEnable: true,
                  buttonColor: AppColors.blueSplashScreen,
                  textColor: AppColors.white,
                ),
                sizedBox(hei: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          );
        });
  }

  Future apiCall(BuildContext context) async {
    debugPrint("API Called success");
    debugPrint("Password is ${passResetCont.text.toString()}");
    if (passResetCont.text.toString().trim() !=
        confPassResetCont.text.toString().trim()) {
      CustomToast(
          context: context, message: "Password in both field must be same");
      return;
    }
    LoginRepository()
        .resetPasswordForgetPasswordLoginAPI(
            token: tokenReset, pass: passResetCont.text.toString().trim())
        .then((value) {
      debugPrint("Success in Resent Password, Now you can login $value");
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.loginView, (route) => false);
    }).onError((error, stackTrace) {
      debugPrint("Failed in Resent Password, Error: $error");
    });
  }
}
