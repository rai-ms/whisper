import 'dart:async';

import 'package:flutter/material.dart';

class OTPAuthViewModel extends ChangeNotifier
{
  int sec = 30;
  bool enableButton = false;
  Timer? timer;

  void startTimer()
  {
    Future.delayed(const Duration(seconds: 1));
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(sec == 0 || sec <= 0){
        debugPrint(sec.toString());
        cancelTimer();
        enableButton = true;
        notifyListeners();
        sec = 30;
      }
      else {
        if(sec == 1){
          enableButton = true;
          notifyListeners();
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

  void sendOTPForVerification() async {
    if(otp != null){
      debugPrint("OTP received: $otp");
      // cancelTimer();
    }
  }

  void resendOTP(){
    enableButton = false;
    sec = 30;
    startTimer();
  }

  // void cancelTimer() {
  //   _sec = 30;
  //   enableButton = true;
  //   _timer?.cancel();
  //   notifyListeners();
  // }

  @override
  void dispose() {
    // cancelTimer();
    super.dispose();
  }
}