import 'package:flutter/cupertino.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import '../../data/app_exceptions/app_exception.dart';
import '../../model/follower_response.dart';
import '../../model/user_profile_response.dart';
import '../../repository/profile_repo/profile_repo.dart';

class PostViewApiResponseProvider extends ChangeNotifier{

  final ProfileRepository profileRepo = ProfileRepository();

  Future<APIResponseUserModel?> getProfile({String? id}) async {
    APIResponseUserModel? res;
    await ProfileRepository.getProfile(id: id).then((APIResponseUserModel? userProfileDataResponse){
      res = userProfileDataResponse;
      if(res!.data!.length != null ) {
        // debugPrint("Length is-------> :${res!.data!.length}");
      }
    }).onError((error, stackTrace){
      throw AppError("$error");
    });
    return res;
  }

  static final PostRepository postRepository = PostRepository();

  static Future<APIResponseCommentModel?> getCommentsList(String id) async {
    APIResponseCommentModel? res;
    await postRepository.getListComments(id).then((value){
      // debugPrint("These are the comments$value of post:$id");
      res = APIResponseCommentModel.fromJson(value!);
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    return res;
  }

  static Future getLikesList(String id) async {

  }

  static Future<GetFollowerApiRes?> getFollowers({String? id}) async {
    GetFollowerApiRes? response;
    await ProfileRepository.getFollowers(id: id).then((GetFollowerApiRes? res){
      response = res;
      debugPrint("Response of getFollowers is: ${res!.data!.followers!.length}");
    }).onError((error, stackTrace){
      debugPrint("Error is $error");
    });
    return response;
  }

  static Future getFollowing({String? id}) async {
    ProfileRepository.getFollowing(id: id).then((value){
      debugPrint("Response of getFollowing is: $value");
    }).onError((error, stackTrace){
      debugPrint("Error is $error");
    });
  }

}