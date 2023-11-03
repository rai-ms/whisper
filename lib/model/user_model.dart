class UserModel {
  String? token;
  UserModel({this.token});
  UserModel.fromJSON(Map<String, dynamic> json) {
    token = json['token'];
  }
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
