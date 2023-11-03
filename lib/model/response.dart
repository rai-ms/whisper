class UploadPostResponse {
  final int statusCode;
  final String type;
  final PostData data;

  UploadPostResponse({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory UploadPostResponse.fromJson(Map<String, dynamic> json) {
    return UploadPostResponse(
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

class PostResponse {
  final int statusCode;
  final String type;
  final List<Post> posts;

  PostResponse({
    required this.statusCode,
    required this.type,
    required this.posts,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsList = json['Posts'];
    final List<Post> posts =
        postsList.map((post) => Post.fromJson(post)).toList();

    return PostResponse(
      statusCode: json['statusCode'],
      type: json['type'],
      posts: posts,
    );
  }
}

class Post {
  final String id;
  final String userId;
  final String url;
  final String mediaType;
  final String caption;
  final int likeCount;
  final int commentCount;
  final bool postStatus;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.postStatus,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      mediaType: json['mediaType'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      postStatus: json['postStatus'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class UserDataFeed {
  String id;
  String username;
  String email;

  UserDataFeed({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserDataFeed.fromJson(Map<String, dynamic> json) {
    return UserDataFeed(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class UserPosts {
  String id;
  String userId;
  String url;
  String mediaType;
  String caption;
  int likeCount;
  int commentCount;

  UserPosts({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
  });

  factory UserPosts.fromJson(Map<String, dynamic> json) {
    return UserPosts(
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

class UserPostData {
  UserDataFeed userData;
  UserPosts userPosts;

  UserPostData({
    required this.userData,
    required this.userPosts,
  });

  factory UserPostData.fromJson(Map<String, dynamic> json) {
    return UserPostData(
      userData: UserDataFeed.fromJson(json['UserData']),
      userPosts: UserPosts.fromJson(json['UserPosts']),
    );
  }
}
