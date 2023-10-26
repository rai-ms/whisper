import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/utils/app_helper/app_url.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/follower_response.dart';


class ProfileRepository {

  static final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> headers = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<APIResponseUserModel?> getProfile ({String? id}) async {
    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };
    APIResponseUserModel? res;
    String? token = await UserData.getUserAccessToken();
    id ??= await UserData.getUserId();

    header['Authorization'] = token!;
    await _baseAPIServices.getAPI("${AppUrl.getMyProfileEndPoint}?userId=$id", header).then((value) {
      // debugPrint("Profile Data fetched $value");
      res = APIResponseUserModel.fromJson(value);
      // debugPrint(res!.data.length.toString());
      // debugPrint(value.toString());
    }).onError((error, stackTrace){
      // debugPrint("Error in profile fetch $error");
      throw AppError("Error----->$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return res;
  }

  static Future<GetFollowerApiRes?> getFollowers({String? id}) async {
    GetFollowerApiRes? apiRes;

    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };

    String? token = await UserData.getUserAccessToken();

    header["Authorization"] = token!;

    id ??= await UserData.getUserId();
    // debugPrint("$id is the id");
    await _baseAPIServices.getAPI("${AppUrl.getFollowersEndPoint}$id", header).then((value) {
      // debugPrint("Followers Data fetched $value");
      // debugPrint(value.toString());
      apiRes = GetFollowerApiRes.fromJson(value);
    }).onError((error, stackTrace){
      // debugPrint("Error in getFollowers fetch $error");
      throw AppError("Error----->$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return apiRes;
  }

  static Future getFollowing({String? id}) async {
    Map<String, dynamic>? apiRes;
    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };

    String? token = await UserData.getUserAccessToken();
    if(id == null){
      id = await UserData.getUserId();
      debugPrint("Id is $id and token is $token");
    }

    await _baseAPIServices.getAPI("${AppUrl.getFollowingEndPoint}?userId=$id", header).then((value) {
      debugPrint("Following Data fetched $value");
      debugPrint(value.toString());
      apiRes = value;
    }).onError((error, stackTrace){
      debugPrint("Error in profile fetch $error");
      throw AppError("Error----->$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return apiRes;
  }

  static Future followUser({String? followingId}) async {
    Map<String, dynamic>? apiRes;
    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };

    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.getAPI("${AppUrl.followUserEndPoint}$followingId", header).then((value) {
      debugPrint("Follow user Data fetched ====================== $value ============================");
      apiRes = value;
    }).onError((error, stackTrace){
      debugPrint("Error in follow user $error");
      throw AppError("Error----->$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return apiRes;
  }

}