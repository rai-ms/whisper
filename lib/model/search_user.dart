class SearchResponseUserData {
  final int statusCode;
  final String type;
  final SearchResponseUserDataDetails data;

  SearchResponseUserData({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory SearchResponseUserData.fromJson(Map<String, dynamic> json) {
    return SearchResponseUserData(
      statusCode: json['statusCode'],
      type: json['type'],
      data: SearchResponseUserDataDetails.fromJson(json['data']),
    );
  }
}

class SearchResponseUserDataDetails {
  final String id;
  final String username;
  final String email;
  final String password;
  final int accountVerify;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final String createdAt;
  final String updatedAt;
  final int v;

  SearchResponseUserDataDetails({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.accountVerify,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SearchResponseUserDataDetails.fromJson(Map<String, dynamic> json) {
    return SearchResponseUserDataDetails(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      accountVerify: json['accountVerify'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      postCount: json['postCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class SearchUserPayload
{
  String? username;
  String? email;

  SearchUserPayload({required this.email, required this.username});

  Map<String, dynamic> toJsonEmail() {
    return {
      'email': email
    };
  }
  Map<String, dynamic> toJsonUsername() {
    return {
      'username': username
    };
  }
}