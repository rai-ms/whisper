import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';
import 'package:whisper/repository/signup_repo/signup_repository.dart';

import '../../utils/routes/route_name.dart';

class OTPAuthViewModel extends ChangeNotifier
{
  int sec = 60;
  bool enableButton = false;
  Timer? timer;
  bool _isValidOTP = true;

  bool get isValidOTP => _isValidOTP;

  set isValidOTP(bool val) {
    _isValidOTP = val;
    notifyListeners();
  }


  void startTimer()  {
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
  void sendOTPForVerification({required bool isForgetPass, required String email, String? pass,required BuildContext context,}) async {
    debugPrint("OTP received: $otp");
    isValidOTP = true;
    notifyListeners();
    debugPrint("OTP received: $otp");
    if(!isForgetPass){
      SignUpRepository signupRepo = SignUpRepository();
      signupRepo.verifyOTP(email, otp!).then((value){
        debugPrint("Verification Success $value");
        Navigator.pushNamed(context, RouteName.loginView);
      }).onError((error, errorStack) {
        debugPrint("Verification Failed $error");
      });
    }
    else
    {
      // Forget Password Code will be here
      LoginRepository().forgetPasswordVerifyOTPLoginAPI({"email": email, "otp": otp}).then((value){
            debugPrint("OTP matched now you can reset $value");
            Navigator.pushNamedAndRemoveUntil(context, RouteName.loginView, (route) => false);
      }).onError((error, stackTrace){

      });

    }
     // cancelTimer();
    }

  void resendOTP(){
    enableButton = false;
    // sec = 60;
    // startTimer();
  }

  @override
  void dispose() {
    // cancelTimer();
    super.dispose();
  }
}