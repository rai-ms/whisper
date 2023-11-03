class ApiResponseUserDataModel {
  final int statusCode;
  final String type;
  final List<ApiResponseUserProfile> data;

  ApiResponseUserDataModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseUserDataModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseUserDataModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: (json['data']['UserPofile'] as List)
          .map((userData) => ApiResponseUserProfile.fromJson(userData))
          .toList(),
    );
  }
}

class ApiResponseUserProfile {
  final String username;
  final String email;
  final String? fullName;
  final String? profilePic;
  final String? profileBio;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final List<ApiResponseUserPost> userPosts;
  final bool isFollowing;
  final bool isFollower;

  ApiResponseUserProfile({
    required this.username,
    required this.profileBio,
    required this.email,
    required this.profilePic,
    required this.fullName,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.userPosts,
    required this.isFollowing,
    required this.isFollower,
  });

  factory ApiResponseUserProfile.fromJson(Map<String, dynamic> json) {
    final userPostsJson = json['UserPosts'] as List;
    final userPosts = userPostsJson
        .map((post) => ApiResponseUserPost.fromJson(post))
        .toList();

    return ApiResponseUserProfile(
      username: json['username'],
      email: json['email'],
      profileBio: json['profileBio'],
      profilePic: json['profilePic'],
      fullName: json['fullName'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      postCount: json['postCount'],
      userPosts: userPosts,
      isFollowing: json['isFollowing'],
      isFollower: json['isFollower'],
    );
  }
}

class ApiResponseUserPost {
  final String id;
  final String userId;
  final String url;
  final String caption;
  final int likeCount;
  final int commentCount;
  final String createdAt;

  ApiResponseUserPost({
    required this.id,
    required this.userId,
    required this.url,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  factory ApiResponseUserPost.fromJson(Map<String, dynamic> json) {
    return ApiResponseUserPost(
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
