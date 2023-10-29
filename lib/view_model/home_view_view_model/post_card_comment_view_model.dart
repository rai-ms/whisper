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


  static String editComment = "";
  static bool isReply = false;
  static String commentId = "";

  // required String commentID
  editMyComment({required BuildContext context,required String editOn,required String commentID}){
    editComment = editOn;
    commentId = commentID;
    isReply = true;
    FocusScope.of(context).requestFocus(commentFocus);
    notifyListeners();
  }

  notAReply(){
    isReply = false;
    notifyListeners();
  }


  final PostRepository postRepository = PostRepository();
  Future<void> sendComment({required String postID,required BuildContext context}) async
  {
    String commentText = commentCont.text.toString().trim();
    if(commentText.isNotEmpty && !isReply){
      await postRepository.createComment(postID, CommentPayload(comment: commentText)).then((value){
        commentCont.clear();
        CustomToast(context: context, message: ToastMsg.commentAdded);
      }).onError((error, stackTrace){
        throw AppError(error.toString());
      });
    }
    else {
      await postRepository.editComment(postId: postID, commendID: commentId, comment: commentText).then((value){
        debugPrint("Comment Edited succes in provider $value");
      }).onError((error, stackTrace){
        debugPrint("Comment Edited succes in provider $error");
      });
      commentCont.clear();
      isReply = false;
      editComment = "";
      notifyListeners();
    }

  }

  @override
  void dispose() {
    commentCont.dispose();
    commentFocus.dispose();
    super.dispose();
  }
}