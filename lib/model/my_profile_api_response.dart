class ApiResponseMyProfileUserDataModel {
  final int statusCode;
  final String type;
  final List<ApiResponseMyProfileUserProfile> data;

  ApiResponseMyProfileUserDataModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseMyProfileUserDataModel.fromJson(
      Map<String, dynamic> json) {
    return ApiResponseMyProfileUserDataModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: (json['data']['UserPofile'] as List)
          .map((userData) => ApiResponseMyProfileUserProfile.fromJson(userData))
          .toList(),
    );
  }
}

class ApiResponseMyProfileUserProfile {
  final String username;
  final String email;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final List<ApiResponseMyProfileUserPost> userPosts;
  final bool isFollowing;
  final bool isFollower;

  ApiResponseMyProfileUserProfile({
    required this.username,
    required this.email,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.userPosts,
    required this.isFollowing,
    required this.isFollower,
  });

  factory ApiResponseMyProfileUserProfile.fromJson(Map<String, dynamic> json) {
    final userPostsJson = json['UserPosts'] as List;
    final userPosts = userPostsJson
        .map((post) => ApiResponseMyProfileUserPost.fromJson(post))
        .toList();

    return ApiResponseMyProfileUserProfile(
      username: json['username'],
      email: json['email'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      postCount: json['postCount'],
      userPosts: userPosts,
      isFollowing: json['isFollowing'],
      isFollower: json['isFollower'],
    );
  }
}

class ApiResponseMyProfileUserPost {
  final String id;
  final String userId;
  final String url;
  final String caption;
  final int likeCount;
  final int commentCount;
  final String createdAt;

  ApiResponseMyProfileUserPost({
    required this.id,
    required this.userId,
    required this.url,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  factory ApiResponseMyProfileUserPost.fromJson(Map<String, dynamic> json) {
    return ApiResponseMyProfileUserPost(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: json['createdAt'],
    );
  }
}
