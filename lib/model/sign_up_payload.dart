class SignUpPayloadModel {
  String email;
  String password;
  String username;
  String name;

  SignUpPayloadModel(
      {required this.email,
      required this.password,
      required this.username,
      required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'username': username
    };
  }
}
