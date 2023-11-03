class GetFollowerApiRes {
  final int statusCode;
  final String type;
  final GetData? data;

  GetFollowerApiRes({
    required this.statusCode,
    required this.type,
    this.data,
  });

  factory GetFollowerApiRes.fromJson(Map<String, dynamic> json) {
    return GetFollowerApiRes(
      statusCode: json['statusCode'],
      type: json['type'],
      data: GetData.fromJson(json['data']),
    );
  }
}

class GetData {
  final List<GetFollower>? followers;

  GetData({
    this.followers,
  });

  factory GetData.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? followersList = json['Followers'];
    List<GetFollower>? followers;

    if (followersList != null) {
      followers = followersList
          .map((followerJson) => GetFollower.fromJson(followerJson))
          .toList();
    }

    return GetData(followers: followers);
  }
}

class GetFollower {
  final GetUser user;

  GetFollower({
    required this.user,
  });

  factory GetFollower.fromJson(Map<String, dynamic> json) {
    return GetFollower(user: GetUser.fromJson(json['User']));
  }
}

class GetUser {
  final String? id;
  final String? username;
  final String? email;
  final String? profilePic;
  final int? accountVerify;

  GetUser({
    this.id,
    this.username,
    this.email,
    this.accountVerify,
    this.profilePic,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) {
    return GetUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      accountVerify: json['accountVerify'],
      profilePic: json['profilePic'],
    );
  }
}
