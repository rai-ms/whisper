import 'package:flutter/cupertino.dart';

import '../../repository/notification_repo/notification_repo.dart';

class NotificationViewModel extends ChangeNotifier
{
  final NotificationRepo notificationRepo = NotificationRepo();
  int pageNo = 1;
  int limit = 10;
  getAllNotification() async {
    await notificationRepo.getAllNotification(limit: limit, pageNo: pageNo,).then((value){}).onError((error, stackTrace){});
  }
}