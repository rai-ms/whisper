class FollowersResponse {
  final int statusCode;
  final String type;
  final List<Follower> followers;

  FollowersResponse({
    required this.statusCode,
    required this.type,
    required this.followers,
  });

  factory FollowersResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> followersList = json['Followers'];
    final List<Follower> followers = followersList
        .map((followerJson) => Follower.fromJson(followerJson))
        .toList();

    return FollowersResponse(
      statusCode: json['statusCode'],
      type: json['type'],
      followers: followers,
    );
  }
}

class Follower {
  final FollowerUser user;

  Follower({
    required this.user,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      user: FollowerUser.fromJson(json['User']),
    );
  }
}

class FollowerUser {
  final String id;
  final String username;
  final String email;
  final int accountVerify;

  FollowerUser({
    required this.id,
    required this.username,
    required this.email,
    required this.accountVerify,
  });

  factory FollowerUser.fromJson(Map<String, dynamic> json) {
    return FollowerUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      accountVerify: json['accountVerify'],
    );
  }
}
