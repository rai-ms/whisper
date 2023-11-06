import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/like.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/repository/post_repo/edit_post_repo.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import 'package:whisper/utils/deBouncer/deBouncer.dart';
import '../../model/comment.dart';
import '../../model/post_api_res.dart';

class PostDetailsProvider extends ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final ProfileRepository profileRepository = ProfileRepository();
  final EditPostRepo editPostRepo = EditPostRepo();
  TextEditingController controller = TextEditingController();
  TextEditingController editPostController = TextEditingController();

  static String? userId = "";
  static String? username;

  Future<String?> getUserName() async {
    username ??= await UserData.getUserUsername();
    // debugPrint("getUserName is $username");
    return username;
  }

  static bool isLiked = false;
  static String postId = "";

  ApiResponsePostModel? apiResponsePostModel;
  ApiResponseUserDataModel? apiResponseUserDataModel;

  Future<ApiResponsePostModel?> getPostDetails() async {
    await postRepository.getPostDetails(postId).then((value) {
      apiResponsePostModel = value;
    }).onError((error, stackTrace) {});
    await ProfileRepository.getProfile(id: apiResponsePostModel!.data[0].userId.toString()).then((value) {
      apiResponseUserDataModel = value;
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getPostDetails $error");
    });
    notifyListeners();
    await getCommentsList();
    notifyListeners();
    return apiResponsePostModel;
  }



  Future editPostCaption() async {
    String caption = editPostController.text.toString().trim();
    debugPrint("Post Edited Called");
    if (caption.isEmpty || apiResponsePostModel == null) return;
    apiResponsePostModel!.data[0].caption = caption;
    notifyListeners();
    await editPostRepo.editPost(postId: postId, caption: caption).then((value) {
      debugPrint("Post Edited Success");
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider editPostCaption $error");
    });
    editPostController.clear();
  }

  DeBouncer _bouncer = DeBouncer(milliseconds: 1000);

  likeThisPost() {
    _bouncer.run(() async {await likePost();});
  }

  Future likePost() async {
    // isLiked = !isLiked;
    apiResponsePostModel!.data[0].isLiked = !apiResponsePostModel!.data[0].isLiked;
    notifyListeners();
    if (apiResponsePostModel!.data[0].isLiked) {
      await postRepository.likePost(postId, userId!).then((value) {
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
  Future<ApiResponseLikesData?> getLikeList(String postId) async {
    await postRepository.getListLikes(postId).then((value) {
      likesData = value;
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getLikeList $error");
    });
    return likesData;
  }
  ApiResponseUserDataModel? user;
  Future<ApiResponseUserDataModel?> getProfileDetails(String id) async {
    await ProfileRepository.getProfile(id: id).then((value){
      user = value;
    }).onError((error, stackTrace){});
    return user;
  }

  APIResponseCommentModel? resCommentSpecificPost;
  Future<APIResponseCommentModel?> getCommentsList() async {
    await postRepository.getListComments(postId).then((value) {
      resCommentSpecificPost = APIResponseCommentModel.fromJson(value!);
    }).onError((error, stackTrace) {
      throw AppError("Error in PostDetailsProvider getCommentsList $error");
    });
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
    return resCommentSpecificPost;
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

  Future deleteMyComment({required String commentId, required BuildContext context}) async {
    await postRepository.deleteComment(postId: postId, commentID: commentId);
  }
}
