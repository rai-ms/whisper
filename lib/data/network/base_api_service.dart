abstract class BaseApiServices {
  Future<dynamic> getAPI(String url, [Map<String, String>? header]);
  Future<dynamic> postAPI(String url, dynamic data);
  Future<dynamic> postAPIWithHeader(
      String url, dynamic data, Map<String, String> header);
  Future<dynamic> patchAPI(String url, dynamic data,
      Map<String, String>? header); // Add PATCH API method
  Future<dynamic> deleteAPI(
      String url, dynamic body, Map<String, String>? header);
}
