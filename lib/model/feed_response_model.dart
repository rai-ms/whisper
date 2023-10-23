class FeedUserData {
  String id;
  String username;
  String email;

  FeedUserData({
    required this.id,
    required this.username,
    required this.email,
  });

  factory FeedUserData.fromJson(Map<String, dynamic> json) {
    return FeedUserData(
      id: json['_id'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
    );
  }
}

class FeedUserPost {
  String id;
  String userId;
  String url;
  String mediaType;
  String caption;
  int likeCount;
  int commentCount;

  FeedUserPost({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
  });

  factory FeedUserPost.fromJson(Map<String, dynamic> json) {
    return FeedUserPost(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      mediaType: json['mediaType'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
    );
  }
}

class FeedApiResponse {
  FeedUserPost feedUserPost;
  FeedUserData feedUserData;

  FeedApiResponse({
    required this.feedUserPost,
    required this.feedUserData,
  });

  factory FeedApiResponse.fromJson(Map<String, dynamic> json) {
    return FeedApiResponse(
      feedUserPost: FeedUserPost.fromJson(json['UserPosts']),
      feedUserData: json['UserData'],
    );
  }
}
