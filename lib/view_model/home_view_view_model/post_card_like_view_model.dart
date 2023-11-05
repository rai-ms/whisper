import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';

import '../../model/feed_response_model.dart';
import '../../model/like.dart';
import '../personal_profile_view_model/api_res_provider.dart';

class LikeViewModel extends ChangeNotifier {
  List<ApiResponseLike>? likes;

  // getAllLikes(UserPosts? posts){
  //   post = posts;
  // }

  likeMyPost(String postId, bool isLiked, String postedById) async {
    notifyListeners();
    await likePost(postId, isLiked,postedById);
  }

  showLikeBottomSheet(Function showBottomSheet) {
    showBottomSheet();
  }

  PostRepository repo = PostRepository();

  Future likePost(String postId, bool isLiked, String postedById) async {
    toggleLikePost(postId, isLiked);
    if (isLiked) {
      repo.dislikePost(postId).then((value) {
        debugPrint("Post-disliked! done in view-model $value");
      }).onError((error, stackTrace) {});
    } else {
      await repo.likePost(postId,postedById).then((value) {
        debugPrint("PostLiked! done in view-model $value");
      }).onError((error, stackTrace) {});
    }
  }

  toggleLikePost(String postId, bool isLike){
    AppGlobalProvider.isPostLikeByMe[postId] = isLike;
    notifyListeners();
  }
}
