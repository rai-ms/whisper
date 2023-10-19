class SignUpPayloadModel
{
  String email;
  String password;
  String username;

  SignUpPayloadModel({required this.email, required this.password, required this.username});

  // factory SignUpPayloadModel.fromJSON(Map<String, dynamic> mp){
  //   return SignUpPayloadModel(email: mp['email'], password: mp['pass'], username: mp['username']);
  // }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username':username
    };
  }

}