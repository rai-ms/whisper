import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_helper/app_strings.dart';
import '../app_exceptions/app_exception.dart';
import 'base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getAPI(String url) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(url));
      debugPrint("Response is Successfully returning");
      return returnResponse(res);
    } on SocketException {
      throw InternetException(AppStrings.noNetwork);
    } on RequestTimeOut {
      throw RequestTimeOut(AppStrings.takingMoreTime);
    }
  }

  @override
  Future postAPI(String url, dynamic data) async {
    debugPrint("$data");
    dynamic responseJSON;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data),)
          .timeout(const Duration(seconds: 10));
      responseJSON = returnResponse(response);
    } catch(e) {
      debugPrint("$e");
    }
    return responseJSON;
  }

  @override
  Future postAPIWithHeader(String url, dynamic data, dynamic header) async {
    dynamic responseJSON;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: header)
          .timeout(const Duration(seconds: 10));
      responseJSON = returnResponse(response);
      // debugPrint(responseJSON.toString());
    } catch(e) {
      debugPrint("Error: $e");
    }
    return responseJSON;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw InvalidUrl(AppStrings.invalidUrl);
      case 500:
        throw InternalServerException(AppStrings.errorServer);
      default:
        throw FetchDataException(AppStrings.unableToFetchData);
    }
  }
}
