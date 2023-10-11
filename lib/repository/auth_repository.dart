import 'package:whisper/data/network/base_api_service.dart';
import 'package:whisper/data/network/network_api_services.dart';

import '../utils/app_helper/app_url.dart';

class AuthRepository
{
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Future<dynamic> loginAPI(dynamic data) async
  {
    dynamic res;
    try{
      res = _baseAPIServices.postAPI(AppUrl.loginEndPoint, data);
    }
    catch(e){
      rethrow;
    }
    return res;
  }

  Future<dynamic> registrationAPI(dynamic data) async
  {
    dynamic  res;
    try{
      res =  _baseAPIServices.postAPI(AppUrl.registerEndPoint, data);
    }
    catch (e){ rethrow;}
  }

  Future<dynamic> userDataGetAPI() async {
    dynamic res;
    try{
      res = _baseAPIServices.getAPI(AppUrl.getUserEndPoint);
      return res;
    }
    catch (e){rethrow;}
  }
}