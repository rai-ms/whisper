class ApiResponseNotificationsModel {
  final int statusCode;
  final String type;
  final List<ApiResponseNotification> data;

  ApiResponseNotificationsModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseNotificationsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'];

    final List<ApiResponseNotification> notifications = data
        .map((notificationJson) => ApiResponseNotification.fromJson(notificationJson))
        .toList();

    return ApiResponseNotificationsModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: notifications,
    );
  }
}

class ApiResponseNotification {
  final String id;
  final String senderId;
  final String receiverId;
  final String activityId;
  final String status;
  final String type;
  final String title;
  final String message;
  final String image;

  ApiResponseNotification({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.activityId,
    required this.status,
    required this.type,
    required this.title,
    required this.message,
    required this.image,
  });

  factory ApiResponseNotification.fromJson(Map<String, dynamic> json) {
    return ApiResponseNotification(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      activityId: json['activityId'],
      status: json['status'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      image: json['image'],
    );
  }
}
