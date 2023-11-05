import 'package:flutter/foundation.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/app_helper/app_enum.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../utils/app_helper/app_url.dart';

class NotificationRepo extends ChangeNotifier {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.contentType: ApiKeys.applicationJson,
  };
  
  Future getAllNotification({required int limit, required int pageNo}) async {
    try {
      String? token = await UserData.getUserAccessToken();
      header[ApiKeys.authorization] = token!;
      debugPrint(header.toString());
      _baseAPIServices.getAPI("https://harshitsocial.appskeeper.in/api/v1/notification?pageNo=$pageNo&limit=$limit").then((value){
        debugPrint("Notification received$value");
      }).onError((error, stackTrace){
        throw AppError("Error in getting notification response $error");
      });
    } catch (e) {
      throw AppError("Error in getting notification response $e");
    }
  }

  Future<void> addPushNotification(String receiverId, String myId, String type) async {
    try {
      await _baseAPIServices.postAPIWithHeader(AppUrl.addNotificationEndPoint,{ "receiverId": receiverId, "activityId": myId, "type": type}, header,).then((value){
        debugPrint("Notification sent of type $type");
      }).onError((error, stackTrace){
        debugPrint("Error in sending notification $error");
      });
    } catch (error){
      debugPrint("Error in sending notification $error");
    }
  }

}
