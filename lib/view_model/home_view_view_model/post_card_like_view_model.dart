import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';

class LikeViewModel extends ChangeNotifier
{

  showLikeBottomSheet(Function showBottomSheet){
    showBottomSheet();
  }

  Future likePost(String postId, bool isLiked) async {
    if(isLiked){
      PostRepository().dislikePost(postId).then((value){
        debugPrint("Post-disliked! done in view-model $value");
      }).onError((error, stackTrace){});
    }
    else {
      await PostRepository().likePost(postId).then((value){
        debugPrint("PostLiked! done in view-model $value");
      }).onError((error, stackTrace){

      });
    }
  }
}