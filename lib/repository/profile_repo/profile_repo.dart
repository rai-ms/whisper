import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/profile_edit_payload.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/utils/app_helper/app_keys.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_url.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/follower_response.dart';
import '../../model/following_response_model.dart';
import '../../model/my_profile_api_response.dart';
import '../../utils/app_helper/app_enum.dart';
import '../notification_repo/notification_repo.dart';

class ProfileRepository {
  static final BaseApiServices _baseAPIServices = NetworkApiServices();

  static Map<String, String> headers = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.contentType: ApiKeys.applicationJson,
  };

  static Future<ApiResponseUserDataModel?> getProfile({String? id}) async {
    Map<String, String> header = {
      ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      ApiKeys.contentType: ApiKeys.applicationJson,
    };
    ApiResponseUserDataModel? res;
    String? token = await UserData.getUserAccessToken();
    id ??= await UserData.getUserId();

    header[ApiKeys.authorization] = token!;
    // debugPrint("Header is $header and id is $id");
    await _baseAPIServices
        .getAPI("${AppUrl.getMyProfileEndPoint}?userId=$id", header)
        .then((value) {
      // debugPrint("Profile Data fetched $value");
      res = ApiResponseUserDataModel.fromJson(value);
      // debugPrint("Length of post are: ${res!.data[0].userPosts.length}");
      // debugPrint(value.toString());
    }).onError((error, stackTrace) {
      // debugPrint("Error in profile fetch $error");
      throw AppError("${AppStrings.error}$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return res;
  }

  static Future<GetFollowerApiRes?> getFollowers({String? id}) async {
    GetFollowerApiRes? apiRes;
    String? token = await UserData.getUserAccessToken();
    headers[ApiKeys.authorization] = token!;
    id ??= await UserData.getUserId();
    await _baseAPIServices
        .getAPI("${AppUrl.getFollowersEndPoint}$id", headers)
        .then((value) {
      // debugPrint("Followers Data fetched $value");
      apiRes = GetFollowerApiRes.fromJson(value);
    }).onError((error, stackTrace) {
      throw AppError("Get Follower Error----->$error");
    });
    return apiRes;
  }

  static Future<GetFollowingApiRes?> getFollowing({String? id}) async {
    GetFollowingApiRes? apiRes;

    String? token = await UserData.getUserAccessToken();
    id ??= await UserData.getUserId();
    headers[ApiKeys.authorization] = token!;
    await _baseAPIServices
        .getAPI("${AppUrl.getFollowingEndPoint}?userId=$id", headers)
        .then((value) {
      // debugPrint("Following Data fetched $value");
      apiRes = GetFollowingApiRes.fromJson(value);
    }).onError((error, stackTrace) {
      debugPrint("Error in following fetch $error");
      throw AppError("Get Following Error----->$error");
    });
    return apiRes;
  }

  static Future followUser({required String followingId}) async {
    Map<String, dynamic>? apiRes;
    debugPrint("Following id is:$followingId");
    String? token = await UserData.getUserAccessToken();
    String? myId = await UserData.getUserId();
    headers[ApiKeys.authorization] = token!;
    await _baseAPIServices.postAPIWithHeader("${AppUrl.followUserEndPoint}$followingId", {}, headers).then((value) {
      // debugPrint("Follow user Data fetched ====================== $value ============================");
      apiRes = value;
    }).onError((error, stackTrace) {
      // debugPrint("Error in follow user $error");
      throw AppError("${AppStrings.error}$error");
    });
    await NotificationRepo().addPushNotification(followingId, myId!, AppNotificationType.FOLLOW);
    return apiRes;
  }

  static Future unfollowUser({String? followingId}) async {
    Map<String, dynamic>? apiRes;
    debugPrint("Following id is:$followingId");

    String? token = await UserData.getUserAccessToken();
    headers[ApiKeys.authorization] = token!;
    // debugPrint("Header is:$headers");
    await _baseAPIServices
        .deleteAPI("${AppUrl.unfollowUserEndPoint}$followingId", {}, headers)
        .then((value) {
      // debugPrint("Follow user Data fetched ====================== $value ============================");
      apiRes = value;
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error}$error");
    });
    // debugPrint("Status code of profile res is: ${res!.statusCode}");
    return apiRes;
  }

  static Future<Map<String, dynamic>?> editProfile(ProfileEditPayload profileEditPayload) async {
    Map<String, dynamic>? res;
    String? id = await UserData.getUserId();
    headers[ApiKeys.authorization] = id!;
    await _baseAPIServices
        .patchAPI(
            AppUrl.editProfileEndPoint, profileEditPayload.toJson(), headers)
        .then((value) {
      // debugPrint("Profile Updated Successfully response is:$value");
      res = value;
    }).onError((error, stackTrace) {
      // debugPrint("Profile Updation caused error, error is:$error");
      throw AppError("${AppStrings.error}$error");
    });
    return res;
  }

  static Future<ApiResponseMyProfileUserDataModel?> getMyProfile() async {
    ApiResponseMyProfileUserDataModel? res;
    String? token = await UserData.getUserAccessToken();
    String? id = await UserData.getUserId();

    headers[ApiKeys.authorization] = token!;
    await _baseAPIServices
        .getAPI("${AppUrl.getMyProfileEndPoint}?userId=$id", headers)
        .then((value) {
      // debugPrint("Profile Data fetched $value");
      res = ApiResponseMyProfileUserDataModel.fromJson(value);
    }).onError((error, stackTrace) {
      throw AppError("Get My Profile Error----->$error");
    });
    return res;
  }
}
