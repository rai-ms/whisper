class Like {
  final String id;
  final String likedBy;
  final String postedBy;
  final String createdAt;
  final int likeType;

  Like({
    required this.id,
    required this.likedBy,
    required this.postedBy,
    required this.createdAt,
    this.likeType = 0, // Default value of 0
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'] as String,
      likedBy: json['likedBy'] as String,
      postedBy: json['postedBy'] as String,
      createdAt: json['createdAt'] as String,
      likeType: json['likeType'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['likedBy'] = likedBy;
    data['postedBy'] = postedBy;
    data['createdAt'] = createdAt;
    data['likeType'] = likeType;
    return data;
  }
}
