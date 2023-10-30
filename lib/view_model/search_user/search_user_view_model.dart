import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/search_user.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';
import 'package:whisper/repository/search_repo/search_repo.dart';
import '../../model/follower_response.dart';
import '../../utils/deBouncer/deBouncer.dart';

class SearchUserViewModel extends ChangeNotifier
{
    TextEditingController controller = TextEditingController();

    DeBouncer deBouncer = DeBouncer(milliseconds: 200);

    onChanged(String val) async {
        if(val.isEmpty) return;
        deBouncer.run(() async {
        await searchUser(username: val).then((value){});});
    }

    SearchResponseUserData? searchResponseUserData;

    final SearchRepository searchRepository = SearchRepository();

    Future searchUser({required String username}) async {
        await searchRepository.searchUser(SearchUserPayload(username: username)).then((value) {
            searchResponseUserData = value;
            // debugPrint("Response is $value");
            notifyListeners();
            controller.clear();
        }).onError((error, stackTrace){
            // debugPrint("Error in Search user View Model :$error");
            searchResponseUserData = null;
            notifyListeners();
        });
    }

    Future followUser(String id) async {
        await ProfileRepository.followUser(followingId: id).then((value){
            debugPrint("User is Followed =========$value===============");
        }).onError((error, stackTrace){});
    }

    Future unfollowUser(String id) async {
        await ProfileRepository.unfollowUser(followingId: id).then((value){
            debugPrint("User is UnFollowed =========$value===============");
        }).onError((error, stackTrace){});
    }

    final ProfileRepository profileRepository = ProfileRepository();

    ApiResponseUserDataModel? apiResponseUserModel;

    Future<ApiResponseUserDataModel?> getProfile(String id) async {
        // debugPrint("Fetching userid: $id");
        ProfileRepository.getProfile(id: id).then((value){
            apiResponseUserModel = value;
            // debugPrint("Fetched userid: $id");
            notifyListeners();
            // debugPrint("${res!.data[0].username}");
        }).onError((error, stackTrace) {
            debugPrint("Error in fetch profile search user view model $error");
            throw AppError(error.toString());
        });
        return apiResponseUserModel;
    }

    Future<GetFollowerApiRes?> getFollowers({String? id}) async {
        GetFollowerApiRes? response;
        await ProfileRepository.getFollowers(id: id).then((GetFollowerApiRes? res){
            response = res;
            // debugPrint("Response of getFollowers is: ${res!.data!.followers!.length}");
        }).onError((error, stackTrace){
            debugPrint("Error is $error");
        });
        return response;
    }
}