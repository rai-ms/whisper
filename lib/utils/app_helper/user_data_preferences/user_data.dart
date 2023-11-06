import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import '../../../model/user.dart';

class UserData {
  static late UserData userdata;
  static SharedPreferences? _preferences;

  UserData._internal() {
    init();
  }

  factory UserData() {
    userdata = UserData._internal();
    return userdata;
  }

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<String?> getUserAccessToken() async {
    final String? userDataString = _preferences?.getString('userData');
    return userDataString;
  }

  static Future<String?> getBio() async {
    final String? userDataString = _preferences?.getString('profileBio');
    return userDataString;
  }

  static Future<String?> getFullName() async {
    final String? userDataString = _preferences?.getString('fullName');
    return userDataString;
  }

  static Future<String?> getProfilePic() async {
    final String? userDataString = _preferences?.getString('profilePic');
    return userDataString;
  }



  static Future<String?> updateUsername(String newUsername) async {
    await _preferences?.setString('username', newUsername).then((value) {
      return true;
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return null;
  }

  static Future<String?> updateFullName(String newFullName) async {
    await _preferences?.setString('fullName', newFullName).then((value) {
      return true;
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return null;
  }

  static Future<String?> updateProfilePic(String newProfilePic) async {
    await _preferences?.setString('profilePic', newProfilePic).then((value) {
      return true;
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return null;
  }

  static Future<String?> updateProfileBio(String newProfileBio) async {
    await _preferences?.setString('profileBio', newProfileBio).then((value) {
      return true;
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return null;
  }

  static Future<bool?> updateBioUsernameProfilePicFullName(
      {String? newProfileBio,
      String? newUsername,
      String? newFullName,
      String? newProfilePic}) async {
    bool res = true;
    if (newUsername != null && newUsername.isNotEmpty) {
      await updateUsername(newUsername).onError((error, stackTrace) {
        res = false;
        return null;
      });
    }
    if (newFullName != null && newFullName.isNotEmpty) {
      await updateFullName(newFullName).onError((error, stackTrace) {
        res = false;
        return null;
      });
    }
    if (newProfileBio != null && newProfileBio.isNotEmpty) {
      await updateProfileBio(newProfileBio).onError((error, stackTrace) {
        res = false;
        return null;
      });
    }
    if (newProfilePic != null && newProfilePic.isNotEmpty) {
      await updateProfilePic(newProfilePic).onError((error, stackTrace) {
        res = false;
        return null;
      });
    }
    return res;
  }

  static Future<String?> getUserUsername() async {
    final String? userDataString = _preferences?.getString('username');
    return userDataString;
  }

  static Future<String?> getUserCreatedAt() async {
    final String? userDataString = _preferences?.getString('createdAt');
    return userDataString;
  }

  static Future<String?> getUserEmail() async {
    final String? userDataString = _preferences?.getString('email');
    return userDataString;
  }

  static Future<String?> getUserId() async {
    final String? userDataString = _preferences?.getString('_id');
    return userDataString;
  }

  static Future<bool> saveUser(User user) async {
    // final Map<String, dynamic> userDataMap = user.toJson();
    // final String userDataString = json.encode(userDataMap);
    // debugPrint("$userDataMap <- This data is going to store into this-> $userDataString");
    await _preferences?.setString('userData', user.accessToken).then((value) {
      debugPrint("Data saved: $value");
    }).onError((error, stackTrace) {
      debugPrint("Unable to save data Error: $error");
    });

    await _preferences?.setString('username', user.username).then((value) {
      debugPrint("Username Data saved: $value");
    }).onError((error, stackTrace) {
      debugPrint("Unable to save Username data Error: $error");
    });

    await _preferences?.setString('createdAt', user.createdAt).then((value) {
      debugPrint("createdAt Data saved: $value");
    }).onError((error, stackTrace) {
      debugPrint("Unable to save createdAt data Error: $error");
    });

    await _preferences?.setString('email', user.email).then((value) {
      debugPrint("email Data saved: $value");
      return true;
    }).onError((error, stackTrace) {
      debugPrint("Unable to save email data Error: $error");
      return false;
    });

    await _preferences?.setString('_id', user.id).then((value) {
      debugPrint("id Data saved: $value");
      return true;
    }).onError((error, stackTrace) {
      debugPrint("Unable to save email data Error: $error");
      return false;
    });

    await _preferences
        ?.setString('profileBio', user.profileBio ?? "Appinventiv")
        .then((value) {
      debugPrint("profileBio Data saved: $value");
      return true;
    }).onError((error, stackTrace) {
      debugPrint("Unable to save profileBio data Error: $error");
      return false;
    });

    await _preferences
        ?.setString(
            'profilePic',
            user.profilePic ??
                "https://appinventiv.com/wp-content/themes/twentynineteen-child/new-images/appinventiv-mask-old.svg")
        .then((value) {
      debugPrint("profilePic Data saved: $value");
      return true;
    }).onError((error, stackTrace) {
      debugPrint("Unable to save profilePic data Error: $error");
      return false;
    });

    await _preferences
        ?.setString('fullName', user.fullName ?? "Appinventiv User")
        .then((value) {
      debugPrint("fullName Data saved: $value");
      return true;
    }).onError((error, stackTrace) {
      debugPrint("Unable to save fullName data Error: $error");
      return false;
    });

    return true;
  }

  static Future<bool> removeUser() async {
    bool remove = true;
    await _preferences?.remove('profileBio').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= true;
    });
    await _preferences?.remove('profilePic').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= true;
    });
    await _preferences?.remove('userData').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= false;
    });
    await _preferences?.remove('_id').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= false;
    });
    await _preferences?.remove('username').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= false;
    });
    await _preferences?.remove('email').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= true;
    });
    await _preferences?.remove('fullName').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= true;
    });
    await _preferences?.remove('createdAt').then((value) {
      remove &= true;
    }).onError((error, stackTrace) {
      remove &= true;
    });
    return remove;
  }
}
