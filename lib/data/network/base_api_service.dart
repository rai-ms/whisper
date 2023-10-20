abstract class BaseApiServices {
  Future<dynamic> getAPI(String url);
  Future<dynamic> postAPI(String url, dynamic data);
  Future<dynamic> postAPIWithHeader(String url, dynamic data, Map<String, String> header);
}
