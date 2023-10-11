class SignUpPayloadModel
{
  String email;
  String password;

  SignUpPayloadModel({required this.email, required this.password});

  factory SignUpPayloadModel.fromJSON(Map<String, dynamic> mp){
    return SignUpPayloadModel(email: mp['email'], password: mp['pass']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

}