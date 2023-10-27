class SearchResponseUserData {
  final int statusCode;
  final String type;
  final List<SearchResponseUser> data;

  SearchResponseUserData({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory SearchResponseUserData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    final List<SearchResponseUser> data = dataList.map((userDataJson) {
      return SearchResponseUser.fromJson(userDataJson);
    }).toList();

    return SearchResponseUserData(
      statusCode: json['statusCode'],
      type: json['type'],
      data: data,
    );
  }
}

class SearchResponseUser {
  final String id;
  final String username;
  final String email;
  final String password;

  SearchResponseUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory SearchResponseUser.fromJson(Map<String, dynamic> json) {
    return SearchResponseUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}


class SearchUserPayload
{
  String? username;

  SearchUserPayload({this.username});

  Map<String, dynamic> toJsonUsername() {
    return {
      'name': username
    };
  }
}