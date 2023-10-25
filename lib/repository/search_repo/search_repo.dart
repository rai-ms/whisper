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

  Future<SearchResponseUserData?> searchUser(String name) async {
    String? token;
    await UserData.getUserAccessToken().then((value){
      token = value;
    }).onError((error, stackTrace){});
    header['Authorization'] = token!;
    await _baseAPIServices.postAPIWithHeader(AppUrl.userSearchEndPoint, {}, header);
  }
}