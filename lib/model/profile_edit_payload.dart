import 'package:flutter/cupertino.dart';

class ProfileEditPayload {
  String? username, profilePic, profileBio, fullName;

  ProfileEditPayload({this.username, this.profileBio, this.profilePic, this.fullName});

  Map<String, dynamic> toJson() {

    Map<String, dynamic> mp = {};
    if (username != null && username!.isNotEmpty) {
      mp['username'] = username;
      debugPrint("$username is username");
    }

    if (profilePic != null && profilePic!.isNotEmpty) {
      mp['profilePic'] = profilePic;
    }

    if (fullName != null && fullName!.isNotEmpty) {
      mp['fullName'] = fullName;
    }

    if (profileBio != null && profileBio!.isNotEmpty) {
      mp['profileBio'] = profileBio;
    }

    return mp;
  }
}
