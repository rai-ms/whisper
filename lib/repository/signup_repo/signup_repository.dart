
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/sign_up_payload.dart';
import '../../utils/app_helper/app_url.dart';

class SignUpRepository
{
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<String> registrationAPI(SignUpPayloadModel model) async
  {
    dynamic  res;
    try{
      res =  _apiServices.postAPI(AppUrl.registerEndPoint, model.toMap());
      Map<String, dynamic> apiAns = await res;
      return apiAns['token'];
    }
    catch (e){ rethrow;}
  }
}