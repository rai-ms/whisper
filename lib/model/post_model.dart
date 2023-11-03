class ApiResponsePostCreatedModel {
  final int statusCode;
  final String type;
  final ApiResponsePostCreatedData data;

  ApiResponsePostCreatedModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponsePostCreatedModel.fromJson(Map<String, dynamic> json) {
    return ApiResponsePostCreatedModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: ApiResponsePostCreatedData.fromJson(json['data']),
    );
  }
}

class ApiResponsePostCreatedData {
  final String userId;
  final String url;
  final String caption;
  final int likeCount;
  final int commentCount;
  final bool postStatus;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  ApiResponsePostCreatedData({
    required this.userId,
    required this.url,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.postStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ApiResponsePostCreatedData.fromJson(Map<String, dynamic> json) {
    return ApiResponsePostCreatedData(
      userId: json['userId'],
      url: json['url'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      postStatus: json['postStatus'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
