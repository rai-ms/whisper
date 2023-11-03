class PostPayload {
  String? caption;
  String url;
  String mediaType;

  PostPayload({required this.url, this.caption, this.mediaType = "Image"});

  Map<String, dynamic> toJson() {
    return {
      if (caption != null) 'caption': caption,
      'url': url,
    };
  }
}

class LoginPayload {
  String email, password;
  LoginPayload({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
