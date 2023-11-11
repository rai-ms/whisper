import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  requestPermissionForFireBaseNotification() async {
    NotificationSettings settings = await messaging.requestPermission(alert: true, announcement: true, badge: true, carPlay: true, criticalAlert: true, provisional: true, sound: true,);
    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Permission Granted");
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint("Permission Granted provisional");
    }
    else {
      openAppSettings();
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

}