import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/like.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/repository/post_repo/edit_post_repo.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../model/comment.dart';
import '../../model/post_api_res.dart';

class PostDetailsProvider extends ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final ProfileRepository profileRepository = ProfileRepository();
  final EditPostRepo editPostRepo = EditPostRepo();
  TextEditingController controller = TextEditingController();

  static String? userId = "";
  static String? username = "";

  getUserName() async {
    if(username!.toString().trim().isNotEmpty) return;
    username ??= await UserData.getUserUsername();
    debugPrint("getUserName is $username");
  }

  static bool isLiked = false;
  static String postId = "";

  ApiResponsePostModel? apiResponsePostModel;
  ApiResponseUserDataModel? apiResponseUserDataModel;

  Future<ApiResponsePostModel?> getPostDetails() async {
    await postRepository.getPostDetails(postId).then((value) {
      apiResponsePostModel = value;
    }).onError((error, stackTrace) {});
    await ProfileRepository.getProfile( id: apiResponsePostModel!.data[0].userId.toString()).then((value) {
      apiResponseUserDataModel = value;
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getPostDetails $error");
    });
    notifyListeners();
    return apiResponsePostModel;
  }

  Future editPostCaption() async {
    String caption = controller.text.toString().trim();
    if (caption.isEmpty || apiResponsePostModel == null) return;
    apiResponsePostModel!.data[0].caption = caption;
    notifyListeners();
    await editPostRepo.editPost(postId: postId, caption: caption).then((value) {
      debugPrint("Post Edited Success");
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider editPostCaption $error");
    });
  }

  Future likePost() async {
    isLiked = !isLiked;
    if (!isLiked) {
      await postRepository.likePost(postId).then((value) {
        // debugPrint("Post Liked! api res");
      }).onError((error, stackTrace) {
        throw AppError("Error in PostDetailsProvider likePost $error");
      });
    } else {
      await postRepository.dislikePost(postId).then((value) {
        debugPrint("Post Disliked!");
      }).onError((error, stackTrace) {
        throw AppError("Error in PostDetailsProvider dislikePost $error");
      });
    }
  }

  ApiResponseLikesData? likesData;
  Future getLikeList(String postId) async {
    String? id = await UserData.getUserId();
    await postRepository.getListLikes(postId).then((value) {
      likesData = value;
      // for(int i = 0; i < likesData!.data.likes.length; ++i) {
      //   if(likesData!.data.likes[i].user.id == id){
      //     isLiked = true;
      //     break;
      //   }
      // }
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getLikeList $error");
    });
    return likesData;
  }

  APIResponseCommentModel? res;
  Future<APIResponseCommentModel?> getCommentsList() async {
    await postRepository.getListComments(postId).then((value) {
      res = APIResponseCommentModel.fromJson(value!);
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getCommentsList $error");
    });
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
    return res;
  }

  Future sendComment(String postedById) async {
    String? comment = controller.text.toString().trim();
    controller.clear();
    if (comment.isEmpty) return;
    await postRepository
        .createComment(postId, CommentPayload(comment: comment),postedById )
        .then((value) {
      debugPrint("Comment Added Done in provider PostDetailsProvider $value");
      notifyListeners();
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider sendComment $error");
    });
  }

  Future deleteMyComment(
      {required String commentId, required BuildContext context}) async {
    await postRepository.deleteComment(postId: postId, commentID: commentId);
  }
}
