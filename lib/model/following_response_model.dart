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
    final List<FollowingUser> following = followingList
        .map((userJson) => FollowingUser.fromJson(userJson))
        .toList();

    return FollowingData(following: following);
  }
}

class FollowingUser {
  final GetUserFollowingResponse user;

  FollowingUser({
    required this.user,
  });

  factory FollowingUser.fromJson(Map<String, dynamic> json) {
    return FollowingUser(user: GetUserFollowingResponse.fromJson(json['User']));
  }
}

class GetUserFollowingResponse {
  final String? id;
  final String? username;
  final String? email;
  final String? profilePic;
  final int? accountVerify;

  GetUserFollowingResponse({
    this.id,
    this.username,
    this.email,
    this.accountVerify,
    this.profilePic,
  });

  factory GetUserFollowingResponse.fromJson(Map<String, dynamic> json) {
    return GetUserFollowingResponse(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilePic'],
      accountVerify: json['accountVerify'],
    );
  }
}
