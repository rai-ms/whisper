import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/search_user.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';
import 'package:whisper/repository/search_repo/search_repo.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../model/follower_response.dart';
import '../../model/following_response_model.dart';
import '../../utils/deBouncer/deBouncer.dart';

class SearchUserViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();

  DeBouncer deBouncer = DeBouncer(milliseconds: 200);
  String? prevSearch;

  onChanged(String val) async {
    if (prevSearch != val) {
      prevSearch = val;
    } else {
      return;
    }
    if (val.isEmpty) return;
    deBouncer.run(() async {
      await searchUser(username: val).then((value) {});
    });
  }

  SearchResponseUserData? searchResponseUserData;

  final SearchRepository searchRepository = SearchRepository();

  Future<SearchResponseUserData?> searchUser({required String username}) async {
    await searchRepository
        .searchUser(SearchUserPayload(username: username))
        .then((value) {
      searchResponseUserData = value;
      // debugPrint("Response is $value");
      notifyListeners();
      // controller.clear();
    }).onError((error, stackTrace) {
      // debugPrint("Error in Search user View Model :$error");
      // searchResponseUserData = null;
      notifyListeners();
    });
    return searchResponseUserData;
  }

  Future followUser(String id) async {
    String? ids = await UserData.getUserId();
    String? username = await UserData.getUserUsername();
    String? email = await UserData.getUserEmail();
    String? profilePic = await UserData.getProfilePic();
    for(int i = 0; i < response!.data!.followers!.length; ++i){
      if(response!.data!.followers![i].user.id == ids){
        break;
      }
    }
    response!.data!.followers!.add(GetFollower(user: GetUser(id: ids, profilePic: profilePic, username: username, email: email, accountVerify: 1)));
    notifyListeners();
    await ProfileRepository.followUser(followingId: id).then((value) {
      // debugPrint("User is Followed =========$value===============");
    }).onError((error, stackTrace) {});
  }

  Future unfollowUser(String id) async {
    String? ids = await UserData.getUserId();
    for(int i = 0; i < response!.data!.followers!.length; ++i){
      if(response!.data!.followers![i].user.id == ids){
        response!.data!.followers!.removeAt(i);
        break;
      }
    }
    notifyListeners();
    await ProfileRepository.unfollowUser(followingId: id).then((value) {
      debugPrint("User is UnFollowed =========$value===============");
    }).onError((error, stackTrace) {});
  }

  final ProfileRepository profileRepository = ProfileRepository();

  ApiResponseUserDataModel? apiResponseUserModel;

  Future<ApiResponseUserDataModel?> getProfile(String id) async {
    // debugPrint("Fetching userid: $id");
    ProfileRepository.getProfile(id: id).then((value) {
      apiResponseUserModel = value;
      // debugPrint("Fetched userid: $id");
      notifyListeners();
      // debugPrint("${res!.data[0].username}");
    }).onError((error, stackTrace) {
      // debugPrint("Error in fetch profile search user view model $error");
      throw AppError(error.toString());
    });
    return apiResponseUserModel;
  }

  GetFollowerApiRes? response;
  Future<GetFollowerApiRes?> getFollowers({String? id}) async {
    if(response != null) return response;
    await ProfileRepository.getFollowers(id: id).then((GetFollowerApiRes? res) {
      response = res;
      // debugPrint("Response of getFollowers is: ${res!.data!.followers!.length}");
    }).onError((error, stackTrace) {
      throw AppError("Get Followers Error:$error");
    });
    notifyListeners();
    return response;
  }

  GetFollowingApiRes? followingApiRes;
  Future<GetFollowingApiRes?> getFollowing({String? id}) async {
    await ProfileRepository.getFollowing(id: id).then((value) {
      followingApiRes = value;
      // debugPrint("Response Received ${followingApiRes!.data.following.length}");
    }).onError((error, stackTrace) {
      throw AppError("Get Followers Error:$error");
    });
    // notifyListeners();
    return followingApiRes;
  }
}
