class ProfileEditPayload {
  String? username, profilePic, profileBio;

  ProfileEditPayload({this.username, this.profileBio, this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "profilePic": profilePic,
      "profileBio": profileBio
    };
  }
}