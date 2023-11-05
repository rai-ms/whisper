import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/data/network/base_api_service.dart';
import 'package:whisper/model/profile_edit_payload.dart';
import 'package:whisper/utils/app_helper/app_keys.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/app_helper/app_url.dart';

class EditProfileRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future editProfile(ProfileEditPayload payload) async {
    if (payload.toJson().isEmpty) return;
    String? id = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = id!;
    debugPrint("Id is: $id");
    await _baseApiServices
        .patchAPI(AppUrl.editProfileEndPoint, payload.toJson(), header)
        .then((value) {
      debugPrint("Profile Updated Successfully in repo, response is:$value");
      return value;
    }).onError((error, stackTrace) {
      debugPrint("Profile failed in edit profile repo error is:$error");
      throw AppError(error.toString());
    });
  }
}
