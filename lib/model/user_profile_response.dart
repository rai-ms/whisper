class UserProfileDataResponse {
  final int statusCode;
  final String type;
  final List<UserProfile> userProfiles;

  UserProfileDataResponse({
    required this.statusCode,
    required this.type,
    required this.userProfiles,
  });

  factory UserProfileDataResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userProfileList = json['UserPofile']; // Correct the typo
    final List<UserProfile> userProfiles = userProfileList
        .map((profileJson) => UserProfile.fromJson(profileJson))
        .toList();

    return UserProfileDataResponse(
      statusCode: json['statusCode'],
      type: json['type'],
      userProfiles: userProfiles,
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

  UserProfile({
    required this.username,
    required this.email,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.userPosts,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userPostsList = json['UserPosts'];
    final List<UserPost> userPosts = userPostsList
        .map((postJson) => UserPost.fromJson(postJson))
        .toList();

    return UserProfile(
      username: json['username'],
      email: json['email'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      postCount: json['postCount'],
      userPosts: userPosts,
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

  UserPost({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
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
    );
  }
}
