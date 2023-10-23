import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/payloads.dart';
import 'package:whisper/model/response.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/app_helper/app_url.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class PostRepository {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization" : "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type":"application/json; charset=UTF-8",
  };

  Future<PostResponse?> createPost(PostPayload data) async {
    PostResponse? res;
    await UserData.getUserAccessToken().then((accessToken) async {
      Map<String, String> resetHeader = {'Content-Type':'application/json; charset=UTF-8', 'Authorization': accessToken!,};
      await _baseAPIServices.postAPIWithHeader(AppUrl.createPostEndPoint, data.toJson(), resetHeader).then((value)
      {
        debugPrint(value['type']);
        try{
          res = PostResponse.fromJson(value);
          debugPrint("$value is the api response ${res!.type}");
        } catch(e) {
          debugPrint("Error in conversion");
        }
      }).onError((error, stackTrace){debugPrint("Error in posting: $error"); throw AppError(error.toString());});
    }).onError((error, stackTrace){debugPrint("UserId fetch error $error");});
    debugPrint("Returning ${res!.statusCode}");
    return res;
  }

  Future<dynamic> resetPasswordForgetPasswordLoginAPI({required String token, required String pass}) async {

    Map<String, dynamic> body = {'newPassword':pass};

    Map<String, String> resetHeader = {'Content-Type':'application/json; charset=UTF-8', 'Authorization':token,};

    debugPrint("$resetHeader is the header and body is $body");
    await _baseAPIServices.postAPIWithHeader(AppUrl.resetPasswordForgetPasswordEmailEndPoint, body, resetHeader).then((value){
      debugPrint("Reset Password success $value");
      return value;
    }).onError((error, stackTrace){
      debugPrint("Reset Password error occur: $error");
      throw UnableToConvert();
    });
    return null;
  }
}
