class GetFollowingApiRes {
  final int statusCode;
  final String type;
  final FollowingData data;

  GetFollowingApiRes({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory GetFollowingApiRes.fromJson(Map<String, dynamic> json) {
    return GetFollowingApiRes(
      statusCode: json['statusCode'],
      type: json['type'],
      data: FollowingData.fromJson(json['data']),
    );
  }
}

class FollowingData {
  final List<FollowingUser> following;

  FollowingData({
    required this.following,
  });

  factory FollowingData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> followingList = json['Following'];
    final List<FollowingUser> following =
    followingList.map((userJson) => FollowingUser.fromJson(userJson)).toList();

    return FollowingData(following: following);
  }
}

class FollowingUser {
  final GetUser user;

  FollowingUser({
    required this.user,
  });

  factory FollowingUser.fromJson(Map<String, dynamic> json) {
    return FollowingUser(user: GetUser.fromJson(json['User']));
  }
}

class GetUser {
  final String? id;
  final String? username;
  final String? email;
  final int? accountVerify;

  GetUser({
    this.id,
    this.username,
    this.email,
    this.accountVerify,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) {
    return GetUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      accountVerify: json['accountVerify'],
    );
  }
}
