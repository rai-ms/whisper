import 'package:flutter/cupertino.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/model/like.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import '../../data/app_exceptions/app_exception.dart';
import '../../model/follower_response.dart';
import '../../model/following_response_model.dart';
import '../../model/user_profile_response.dart';
import '../../repository/profile_repo/profile_repo.dart';

class PostViewApiResponseProvider extends ChangeNotifier{

  final ProfileRepository profileRepo = ProfileRepository();

  ApiResponseUserDataModel? res;

  Future<ApiResponseUserDataModel?> getProfile({String? id}) async {
    await ProfileRepository.getProfile(id: id).then((ApiResponseUserDataModel? userProfileDataResponse){
      res = userProfileDataResponse;
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

  static Future<ApiResponseLikesData?> getLikesList(String id) async {
    ApiResponseLikesData? res;
    await postRepository.getListLikes(id).then((value){
      res = value;
    }).onError((error, stackTrace){});
    return res;
  }


  static Future<LikeAndCommentOfApiResponse?> getLikesAndComments(String id) async {
    LikeAndCommentOfApiResponse? res;
    APIResponseCommentModel? comment;
    ApiResponseLikesData? likes;
    await getCommentsList(id).then((value){
      comment = value;
    }).onError((error, stackTrace){});
    await getLikesList(id).then((value){
      likes = value;
    }).onError((error, stackTrace){});
    res = LikeAndCommentOfApiResponse(comments: comment, likes: likes);
    return res;
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

  static Future<GetFollowingApiRes?> getFollowing({String? id}) async {
    GetFollowingApiRes? res;
    await ProfileRepository.getFollowing(id: id).then((value){
      // debugPrint("Response of getFollowing is: ************************************************* $value *************************************************");
      res = value;
    }).onError((error, stackTrace){
      debugPrint("Error is $error");
    });

    return res;
  }

}

class LikeAndCommentOfApiResponse {
  ApiResponseLikesData? likes;
  APIResponseCommentModel? comments;

  LikeAndCommentOfApiResponse({this.comments, this.likes});
}