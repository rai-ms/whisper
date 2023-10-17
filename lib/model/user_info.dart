class UserInfo {
  final String image;
  final String name;
  final String id;

  UserInfo({
    required this.image,
    required this.name,
    required this.id,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'id': id,
    };
  }
}


