import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/app_helper/app_keys.dart';

class EditPostRepo {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> headers = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.contentType: ApiKeys.applicationJson,
  };

}