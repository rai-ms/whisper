import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/toast_message.dart';

import '../../repository/post_repo/post_repo.dart';

class PostCardCommentViewModel extends ChangeNotifier
{
  var commentCont = TextEditingController();
  FocusNode commentFocus = FocusNode();
  bool loading = false;


  String replyText = "";

  gotoReply(BuildContext context, String replyOn){
    replyText = replyOn;
    FocusScope.of(context).requestFocus(commentFocus);
  }


  final PostRepository postRepository = PostRepository();
  Future<void> sendComment({required String postID,required BuildContext context}) async
  {
    String commentText = commentCont.text.toString().trim();
    if(commentText.isNotEmpty){
      await postRepository.createComment(postID, CommentPayload(comment: commentText)).then((value){
        commentCont.clear();
        CustomToast(context: context, message: ToastMsg.commentAdded);
      }).onError((error, stackTrace){
        throw AppError(error.toString());
      });
    }

  }

  @override
  void dispose() {
    commentCont.dispose();
    commentFocus.dispose();
    super.dispose();
  }
}