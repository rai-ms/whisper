import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/toast_message.dart';
import '../../repository/post_repo/post_repo.dart';

class PostCardCommentViewModel extends ChangeNotifier {
  var commentCont = TextEditingController();
  FocusNode commentFocus = FocusNode();
  bool loading = false;

  static String editComment = "";
  static bool isReply = false;
  static String commentId = "";

  // required String commentID
  editMyComment(
      {required BuildContext context,
      required String editOn,
      required String commentID}) {
    editComment = editOn;
    commentId = commentID;
    isReply = true;
    FocusScope.of(context).requestFocus(commentFocus);
    notifyListeners();
  }

  notAReply() {
    isReply = false;
    notifyListeners();
  }

  Future deleteMyComment(
      {required String postId,
      required String commentId,
      required BuildContext context}) async {
    await postRepository
        .deleteComment(
      postId: postId,
      commentID: commentId,
    )
        .then((value) {
      debugPrint("Comment Deleted Success");
      CustomToast(message: "Comment Deleted Success", context: context);
    }).onError((error, stackTrace) {
      debugPrint("Comment Deletion failed Error:$error");
    });
  }

  final PostRepository postRepository = PostRepository();

  Future<void> sendComment({required String postID, required BuildContext context, required String postedById}) async {
    String commentText = commentCont.text.toString().trim();
    if (commentText.isNotEmpty && !isReply) {
      await postRepository
          .createComment(postID, CommentPayload(comment: commentText), postedById)
          .then((value) {
        // debugPrint("---------------------------------Comment Response is :$value ---------------------------------");
        commentCont.clear();
        CustomToast(context: context, message: ToastMsg.commentAdded);
      }).onError((error, stackTrace) {
        throw AppError(error.toString());
      });
    } else {
      await postRepository
          .editComment(
              postId: postID, commendID: commentId, comment: commentText)
          .then((value) {
        debugPrint("Comment Edited success in provider $value");
      }).onError((error, stackTrace) {
        debugPrint("Comment Edited failed in provider $error");
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

  APIResponseCommentModel? res;
  Future<APIResponseCommentModel?> getAllComment(String postId) async {
    postRepository.getListComments(postId).then((value){
      debugPrint("Comment Received!");
      res = APIResponseCommentModel.fromJson(value!);
      notifyListeners();
    }).onError((error, stackTrace){});
    return res;
  }


}
