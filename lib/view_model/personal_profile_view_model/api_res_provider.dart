import 'package:flutter/cupertino.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import '../../data/app_exceptions/app_exception.dart';
import '../../model/user_profile_response.dart';
import '../../repository/profile_repo/profile_repo.dart';

class PostViewApiResponseProvider extends ChangeNotifier{

  final ProfileRepository profileRepo = ProfileRepository();

  Future<UserProfileDataResponse?> getProfile({String? id}) async {
    UserProfileDataResponse? res;
    await profileRepo.getProfile(id: id).then((UserProfileDataResponse? userProfileDataResponse){
      res = userProfileDataResponse;
      debugPrint( "Username is :${res!.userProfiles[0].username}");
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

}