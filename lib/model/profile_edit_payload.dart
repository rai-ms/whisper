class ProfileEditPayload {
  String? username, profilePic, profileBio;

  ProfileEditPayload({this.username, this.profileBio, this.profilePic});

  Map<String, dynamic> toJson() {

    Map<String, dynamic> mp =  {};
    if(username != null ){
      mp['username'] = username;
    }

    if(profilePic != null && profilePic!.isNotEmpty){
      mp['profilePic'] = profilePic;
    }

    if(profileBio != null){
      mp['profileBio'] = profileBio;
    }

    return mp;
  }
}