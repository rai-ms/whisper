import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';

import '../../model/feed_response_model.dart';
import '../../model/like.dart';

class LikeViewModel extends ChangeNotifier
{
  List<ApiResponseLike>? likes;


  // getAllLikes(UserPosts? posts){
  //   post = posts;
  // }

  likeMyPost(String postId, bool isLiked) async {
    notifyListeners();
    await likePost(postId, isLiked);
  }

  showLikeBottomSheet(Function showBottomSheet){
    showBottomSheet();
  }

  PostRepository repo = PostRepository();

  Future likePost(String postId, bool isLiked) async {
    notifyListeners();
    if(isLiked){
      repo.dislikePost(postId).then((value){
        debugPrint("Post-disliked! done in view-model $value");
      }).onError((error, stackTrace){});
    }
    else {
      await repo.likePost(postId).then((value){
        debugPrint("PostLiked! done in view-model $value");
      }).onError((error, stackTrace){

      });
    }
  }
}