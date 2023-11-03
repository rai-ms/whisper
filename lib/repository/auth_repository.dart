import '../data/network/base_api_service.dart';
import '../data/network/network_api_services.dart';
import '../model/user_model.dart';
import '../utils/app_helper/app_url.dart';

class AuthRepository {
  final BaseApiServices _baseAPIServices = NetworkApiServices();
  Future<dynamic> loginAPI(dynamic data) async {
    dynamic res;
    try {
      res = _baseAPIServices.postAPI(AppUrl.loginEndPoint, data);
      Map<String, dynamic> apiAns = await res;
      // return UserModel.fromJSON(apiAns);
      return apiAns;
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> userDataGetAPI() async
  // {
  //   dynamic res;
  //   try{
  //     res = _baseAPIServices.getAPI(AppUrl.getUserEndPoint);
  //     return res;
  //   }
  //   catch (e){rethrow;}
  // }
}
