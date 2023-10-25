import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/utils/app_helper/app_url.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';

import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';

class ProfileRepository {
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<UserProfileDataResponse?> getProfile({String? id}) async {
    UserProfileDataResponse? res;
    String? token = await UserData.getUserAccessToken();
    id ??= await UserData.getUserId();
    header['Authorization'] = token!;
    await _baseAPIServices.getAPI("${AppUrl.getMyProfileEndPoint}?userId=$id", header).then((value) {
      // debugPrint("Profile Data fetched $value");
      res = UserProfileDataResponse.fromJson(value);
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    // debugPrint("Status code is ${res!.statusCode}");
    return res;
  }

}