import 'package:flutter/cupertino.dart';

import '../../model/notification_model.dart';
import '../../repository/notification_repo/notification_repo.dart';

class NotificationViewModel extends ChangeNotifier
{
  final NotificationRepo notificationRepo = NotificationRepo();
  int pageNo = 1;
  int limit = 10;

  ApiResponseNotificationsModel? notificationsModel;
  Future<ApiResponseNotificationsModel?> getAllNotification() async {
    await notificationRepo.getAllNotification(limit: limit, pageNo: pageNo,).then((value){
      notificationsModel = value;
      Future.delayed(const Duration(seconds: 1));
      notifyListeners();
    }).onError((error, stackTrace){});
    return notificationsModel;
  }
}