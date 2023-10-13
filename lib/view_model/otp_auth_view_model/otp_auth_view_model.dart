import 'dart:async';

import 'package:flutter/material.dart';

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
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(sec == 0 || sec <= 0) {
        debugPrint(sec.toString());
        cancelTimer();
        enableButton = true;
        sec = 60;
      }
      else {
        if(sec <= 1){
          enableButton = true;
        }
        sec--;
      }
      debugPrint(enableButton.toString());
      notifyListeners();

    });
  }

  void cancelTimer() {
    timer!.cancel();
  }

  String? otp;

  /// Api Call
  /// if Success and [isForgetPass] is true then will navigate to reset password otherwise navigate to Home Page with login
  void sendOTPForVerification(bool isForgetPass) async {
    if(otp != null){
      debugPrint("OTP received: $otp");
      isValidOTP = true;
      notifyListeners();
      cancelTimer();

    }
  }

  void resendOTP(){
    enableButton = false;
    sec = 60;
    startTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}