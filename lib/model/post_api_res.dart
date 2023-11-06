class ApiResponsePostModel {
  final int statusCode;
  final String type;
  final List<ApiResponsePost> data;

  ApiResponsePostModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponsePostModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postData = json['data'];

    final List<ApiResponsePost> posts =
        postData.map((postJson) => ApiResponsePost.fromJson(postJson)).toList();

    return ApiResponsePostModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: posts,
    );
  }
}

class ApiResponsePost {
  final String id;
  final String userId;
  final String url;
  String caption;
  final int likeCount;
  final int commentCount;
  final String createdAt;
  bool isLiked;

  ApiResponsePost({
    required this.id,
    required this.userId,
    required this.url,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.isLiked,
  });

  factory ApiResponsePost.fromJson(Map<String, dynamic> json) {
    return ApiResponsePost(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      isLiked: json['isLiked'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: json['createdAt'],
    );
  }
}
