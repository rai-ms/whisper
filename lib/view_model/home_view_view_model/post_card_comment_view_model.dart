import 'package:flutter/cupertino.dart';

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


  sendComment()
  {
    commentCont.clear();
  }

  @override
  void dispose() {
    commentCont.dispose();
    commentFocus.dispose();
    super.dispose();
  }
}