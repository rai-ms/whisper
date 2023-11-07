import 'package:flutter/foundation.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/notification_model.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../utils/app_helper/app_url.dart';

class NotificationRepo {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };
  
  Future<ApiResponseNotificationsModel?> getAllNotification({required int limit, required int pageNo}) async {
    ApiResponseNotificationsModel? res;
    try {
      String? token = await UserData.getUserAccessToken();
      header[ApiKeys.authorization] = token!;
      // debugPrint(header.toString());
      await _baseAPIServices.getAPI("${AppUrl.notificationEndPoint}?pageNo=1&limit=10000", header).then((value){
        // debugPrint("Notification received$value");
        res = ApiResponseNotificationsModel.fromJson(value);
      }).onError((error, stackTrace){
        throw AppError("Error in getting notification response $error");
      });
    } catch (e) {
      throw AppError("Error in getting notification response $e");
    }

    return res;
  }

  Future<void> addPushNotification(String receiverId, String activityId, String type) async {
    debugPrint("Received type is $type");
    String? token = await UserData.getUserAccessToken();
    Map<String, String> headers = {ApiKeys.authorization : token!, ApiKeys.contentType : ApiKeys.applicationJson};
    debugPrint("Receiver id is $receiverId and header is $headers");
      await _baseAPIServices.postAPIWithHeader(AppUrl.addNotificationEndPoint,{ "receiverId": receiverId, "activityId": activityId, "type": type}, headers,).then((value){
        debugPrint("Notification sent of type $value");
      }).onError((error, stackTrace){
        debugPrint("Error in sending notification $error");
      });
      return;
  }

  Future deleteNotification({required String notificationId}) async {
    String? token = await UserData.getUserAccessToken();
    Map<String, String> headers = {ApiKeys.authorization : token!, ApiKeys.contentType : ApiKeys.applicationJson};
    await _baseAPIServices.deleteAPI("${AppUrl.deleteNotificationEndPoint}?notificationId=$notificationId", {}, headers).then((value){
      debugPrint("Notification Deleted response is:$value");
    }).onError((error, stackTrace){
      debugPrint("Notification Deletion error is:$error");
    });
  }

}
