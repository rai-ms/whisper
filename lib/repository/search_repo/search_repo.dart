import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/utils/app_helper/app_url.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/search_user.dart';

class SearchRepository {
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<SearchResponseUserData?> searchUser(SearchUserPayload payload) async {
    SearchResponseUserData? res;
    String? token;
    await UserData.getUserAccessToken().then((value) {
      token = value;
    }).onError((error, stackTrace) {});
    header['Authorization'] = token!;
    await _baseAPIServices
        .getAPI("${AppUrl.userSearchEndPoint}${payload.username}", header)
        .then((value) {
      debugPrint("Search Response is $value");
      res = SearchResponseUserData.fromJson(value);
      debugPrint("${res!.data[0].id} is the id");
    }).onError((error, stackTrace) {
      // debugPrint("Error in Search User $error");
      throw AppError("Error $error");
    });
    return res;
  }
}
