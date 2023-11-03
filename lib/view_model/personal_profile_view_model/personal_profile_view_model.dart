import 'package:flutter/cupertino.dart';

import '../../model/follower_response.dart';
import '../../model/following_response_model.dart';
import '../../model/my_profile_api_response.dart';
import '../../repository/profile_repo/profile_repo.dart';

class PersonalProfileViewModel extends ChangeNotifier {
  int _index = 0;
  // PageController profilePageController = PageController(
  //   initialPage: 0, keepPage: false, viewportFraction: 1,);

  set index(int val) {
    _index = val;
    // profilePageController.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

  int get index => _index;

  ApiResponseMyProfileUserDataModel? apiResponseMyProfileUserDataModel;

  Future<ApiResponseMyProfileUserDataModel?> getMyProfileData() async {
    await ProfileRepository.getMyProfile().then((value) {
      apiResponseMyProfileUserDataModel = value;
    }).onError((error, stackTrace) {});
    return apiResponseMyProfileUserDataModel;
  }

  static Future<GetFollowerApiRes?> getFollowers({String? id}) async {
    GetFollowerApiRes? response;
    await ProfileRepository.getFollowers(id: id).then((GetFollowerApiRes? res) {
      response = res;
      debugPrint(
          "Response of getFollowers is: ${res!.data!.followers!.length}");
    }).onError((error, stackTrace) {
      debugPrint("Error is $error");
    });
    return response;
  }

  static Future<GetFollowingApiRes?> getFollowing({String? id}) async {
    GetFollowingApiRes? res;
    await ProfileRepository.getFollowing(id: id).then((value) {
      // debugPrint("Response of getFollowing is: ************************************************* $value *************************************************");
      res = value;
    }).onError((error, stackTrace) {
      debugPrint("Error is $error");
    });

    return res;
  }
}
