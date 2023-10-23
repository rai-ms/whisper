class PostPayload
{
  String? caption;
  String url;
  String mediaType;

  PostPayload({required this.url, this.caption, this.mediaType = "Image"});

  Map<String, dynamic> toJson() {
    return {
      if(caption != null) 'caption': caption,
      'url': url,
      'mediaType': mediaType,
    };
  }
}

class LoginPayload
{
  String mail, password;
  LoginPayload({required this.mail, required this.password});
  Map<String, dynamic> toJson() {
    return {
      'mail': mail,
      'password': password,
    };
  }
}