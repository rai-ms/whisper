/// These are the keys of the Scrollable Widget, which will store the state of that widget
class StoragePathKey {
  static const String postViewPath = "postViewPath";
  static const String notificationPath = "notificationPath";
  static const String friendsListPath = "friendsListPath";
  static const String photosListPath = "photosListPath";
  static const String postListPath = "postListPath";
  static const String postListPathFuture = "postListPath";
}

class AppKeys {
  static const String appName = 'whisper';
  static const String token = 'token';
  static const String email = 'email';
  static const String password = 'password';
  static const String somethingWentWrong = 'Something Went Wrong';
  static const String id = 'id';
}

abstract class ApiKeys {
  // HEADER keys
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';
  static const String patchMethod = 'PATCH';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String authorization = 'Authorization';
  static const String accept = 'accept';
  static const String userAgent = 'User-Agent';
  static const String formUrlEncoded = 'application/x-www-form-urlencoded';

  // request keys
  static const String fields = 'fields';
  static const String files = 'files';
  static const String error = 'Error';
  static const String msg = 'msg';
  static const String status = 'status';
  static const String message = 'message';
  static const String data = 'data';
  static const String token = 'token';
  static const String loginType = 'loginType';
  static const String statusCode = 'statusCode';
}

class AppPreferenceKeys {
  static const String token = 'token';
  static const String userID = 'userID';
  static const String userData = 'userData';
}
