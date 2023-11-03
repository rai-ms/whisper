import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/user.dart';
import '../../utils/app_helper/app_url.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class LoginRepository {
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<User?> loginAPI(dynamic data) async {
    await _baseAPIServices
        .postAPIWithHeader(AppUrl.loginEndPoint, data, header)
        .then((value) {
      // debugPrint("$value is the api response");
      Map<String, dynamic> apiAns = value;
      debugPrint("$apiAns is the api response");
      User user = User.fromJson(apiAns['data']);
      UserData.saveUser(user).then((value) {
        // debugPrint("Data Saved in App Local");
      }).onError((error, stackTrace) {
        debugPrint("Unable to Save data in App Local");
      });
      // debugPrint("${UserData.getUserAccessToken()}");
      return user;
    }).onError((error, stackTrace) {
      debugPrint("Data Received with error occur: $error");
      throw UnableToConvert();
    });

    return null;
  }

  Future<String?> forgetPasswordLoginAPI(dynamic data) async {
    await _baseAPIServices
        .postAPIWithHeader(AppUrl.forgetPasswordEmailEndPoint, data, header)
        .then((value) {
      debugPrint("Forget Password OTP sent success $value");
      debugPrint("Forget Password OTP sent success ${value['statusCode']}");
      return value['statusCode'].toString();
    }).onError((error, stackTrace) {
      debugPrint("Data Received with error occur: $error");
      throw UnableToConvert();
    });
    return null;
  }

  Future<Map<String, dynamic>?> forgetPasswordVerifyOTPLoginAPI(
      dynamic data) async {
    Map<String, dynamic>? res;
    await _baseAPIServices
        .postAPIWithHeader(
            AppUrl.verifyOTPForgetPasswordEmailEndPoint, data, header)
        .then((value) {
      debugPrint("Verify OTP sent success $value");
      res = value;
    }).onError((error, stackTrace) {
      debugPrint("Verify OTP forget password error occur: $error");
      throw UnableToConvert();
    });
    return res;
  }

  Future<dynamic> resetPasswordForgetPasswordLoginAPI(
      {required String token, required String pass}) async {
    Map<String, dynamic> body = {'newPassword': pass};

    Map<String, String> resetHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    };

    debugPrint("$resetHeader is the header and body is $body");
    await _baseAPIServices
        .postAPIWithHeader(
            AppUrl.resetPasswordForgetPasswordEmailEndPoint, body, resetHeader)
        .then((value) {
      debugPrint("Reset Password success $value");
      return value;
    }).onError((error, stackTrace) {
      debugPrint("Reset Password error occur: $error");
      throw UnableToConvert();
    });
    return null;
  }

  Future<String?> resendPassword(dynamic data) async {
    await _baseAPIServices
        .postAPIWithHeader(
            AppUrl.resendOtpForgetPasswordEmailEndPoint, data, header)
        .then((value) {
      debugPrint("Resend OTP Success $value");
    }).onError((error, stackTrace) {
      debugPrint("Resend OTP Failed $error");
    });
    return null;
  }

  Future<bool?> logoutUser() async {
    bool? res;
    await UserData.getUserAccessToken().then((token) async {
      debugPrint("Token received for logout: $token");
      header['Authorization'] = token!;
      await _baseAPIServices
          .postAPIWithHeader(AppUrl.logoutEndPoint, {}, header)
          .then((value) {
        debugPrint("logout Success");
        res = true;
      }).onError((error, stackTrace) {
        debugPrint("Data Received with error occur: $error");
        res = false;
        throw AppError(error.toString());
      });
    }).onError((error, stackTrace) {
      res = false;
      throw AppError(error.toString());
    });
    return res;
  }
}
