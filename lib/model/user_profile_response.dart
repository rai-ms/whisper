class APIResponseUserModel {
  final int statusCode;
  final String type;
  final List<UserProfile> data;

  APIResponseUserModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory APIResponseUserModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userProfileList = json['data']['UserPofile'];
    final List<UserProfile> data = userProfileList.map((userProfileJson) {
      return UserProfile.fromJson(userProfileJson);
    }).toList();

    return APIResponseUserModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: data,
    );
  }
}

class UserProfile {
  final String username;
  final String email;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final List<UserPost> userPosts;
  final bool isFollowing;
  final bool isFollower;

  UserProfile({
    required this.username,
    required this.email,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.userPosts,
    required this.isFollowing,
    required this.isFollower,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userPostsList = json['UserPosts'];
    final List<UserPost> userPosts = userPostsList.map((userPostJson) {
      return UserPost.fromJson(userPostJson);
    }).toList();

    return UserProfile(
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

class UserPost {
  final String id;
  final String userId;
  final String url;
  final String mediaType;
  final String caption;
  final int likeCount;
  final int commentCount;
  final String createdAt;

  UserPost({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      mediaType: json['mediaType'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: json['createdAt'],
    );
  }
}

