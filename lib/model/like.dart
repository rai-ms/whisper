class Like {
  final String id;
  final String likedBy;
  final String postedBy;
  final String createdAt;
  // final int likeType;

  Like({
    required this.id,
    required this.likedBy,
    required this.postedBy,
    required this.createdAt,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'] as String,
      likedBy: json['likedBy'] as String,
      postedBy: json['postedBy'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['likedBy'] = likedBy;
    data['postedBy'] = postedBy;
    data['createdAt'] = createdAt;
    return data;
  }
}

class ApiResponseLikesData {
  final int statusCode;
  final String type;
  final ApiResponseLikesResponseData data;

  ApiResponseLikesData({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseLikesData.fromJson(Map<String, dynamic> json) {
    return ApiResponseLikesData(
      statusCode: json['statusCode'],
      type: json['type'],
      data: ApiResponseLikesResponseData.fromJson(json['data']),
    );
  }
}

class ApiResponseLikesResponseData {
  final List<ApiResponseLike> likes;

  ApiResponseLikesResponseData({
    required this.likes,
  });

  factory ApiResponseLikesResponseData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> likesList = json['Likes'];
    final List<ApiResponseLike> likes = likesList.map((likeJson) {
      return ApiResponseLike.fromJson(likeJson);
    }).toList();

    return ApiResponseLikesResponseData(likes: likes);
  }
}

class ApiResponseLike {
  final ApiResponseUser user;

  ApiResponseLike({
    required this.user,
  });

  factory ApiResponseLike.fromJson(Map<String, dynamic> json) {
    return ApiResponseLike(user: ApiResponseUser.fromJson(json['User']));
  }
}

class ApiResponseUser {
  final String id;
  final String username;
  final String email;

  ApiResponseUser({
    required this.id,
    required this.username,
    required this.email,
  });

  factory ApiResponseUser.fromJson(Map<String, dynamic> json) {
    return ApiResponseUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
