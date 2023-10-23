class PostResponse {
  final int statusCode;
  final String type;
  final PostData data;

  PostResponse({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      statusCode: json['statusCode'],
      type: json['type'],
      data: PostData.fromJson(json['data']),
    );
  }
}

class PostData {
  final String userId;
  final String url;
  final String mediaType;
  final String caption;
  final int likeCount;
  final int commentCount;
  final bool postStatus;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  PostData({
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.postStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      userId: json['userId'],
      url: json['url'],
      mediaType: json['mediaType'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      postStatus: json['postStatus'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
