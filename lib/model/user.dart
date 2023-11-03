class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final int accountVerify;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final String createdAt;
  final int v;
  final String accessToken;
  final String? fullName, profilePic, profileBio;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.accountVerify,
      required this.followerCount,
      required this.followingCount,
      required this.postCount,
      required this.createdAt,
      required this.v,
      required this.accessToken,
      this.fullName,
      this.profilePic,
      this.profileBio});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['_id'] ?? "",
      username: json['user']['username'] ?? "",
      email: json['user']['email'] ?? "",
      password: json['user']['password'] ?? "",
      fullName: json['user']['fullName'] ?? "",
      profilePic: json['user']['profilePic'] ?? "",
      profileBio: json['user']['profileBio'] ?? "",
      accountVerify: json['user']['accountVerify'] ?? 0,
      followerCount: json['user']['followerCount'] ?? 0,
      followingCount: json['user']['followingCount'] ?? 0,
      postCount: json['user']['postCount'] ?? 0,
      createdAt: json['user']['createdAt'] ?? "",
      v: json['user']['__v'] ?? 0,
      accessToken: json['accessToken'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'accountVerify': accountVerify,
      'followerCount': followerCount,
      'followingCount': followingCount,
      'postCount': postCount,
      'createdAt': createdAt,
      '__v': v,
      'accessToken': accessToken,
    };
  }
}
