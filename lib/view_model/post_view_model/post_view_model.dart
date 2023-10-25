import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/model/feed_response_model.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/toast_message.dart';
import '../../repository/post_repo/post_repo.dart';

class PostViewModel extends ChangeNotifier
{

  static FeedApiResponse? feedApiResponse;

  static PostRepository postRepo = PostRepository();

  static Future<FeedApiResponse?> getAllPost() async {
    await postRepo.getMyFeed().then((value){
      feedApiResponse = value!;
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    return feedApiResponse;
  }
  static getUserProfileData(String id){

  }

  static Future createComment({required String postId, required BuildContext context}) async {
    await postRepo.createComment(postId, CommentPayload(comment: "Hii")).then((value){
      CustomToast(context: context, message: ToastMsg.commentAdded);
    }).onError((error, stackTrace){
      debugPrint("Error :$error");
    });
  }
}