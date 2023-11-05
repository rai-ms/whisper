import 'package:flutter/cupertino.dart';

import '../../data/app_exceptions/app_exception.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class EditPostRepo {
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    ApiKeys.contentType: ApiKeys.applicationJson,
  };

  Future<String?> editPost({required String postId, required String caption,}) async {
    String? statusCode;
    debugPrint("Going to edit on $postId");
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices.patchAPI("https://harshitsocial.appskeeper.in/api/v1/user/editPost?postId=$postId", {"caption": caption,}, header).then((value) {
      debugPrint("Edited on post :$postId status is $value");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("Error is:$error");
    });
    return statusCode;
  }
}
