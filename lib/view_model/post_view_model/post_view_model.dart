import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/feed_response_model.dart';
import '../../repository/post_repo/post_repo.dart';
import '../global_provider/global_provider.dart';

class PostViewModel extends ChangeNotifier {
  static bool isFirstPage = true;

  static PostRepository postRepo = PostRepository();

  static int limit = 100000000;
  static int pageNo = 1;

  UserFeedModel? feedApiResponse;
  Future<UserFeedModel?> getAllPost() async {
    isFirstPage = false;
    await postRepo.getMyFeed(pageNo: pageNo, limit: limit).then((value) async {
      feedApiResponse = value!;
      // notifyListeners();
      // await updateAllLikes(feedApiResponse!);
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    // notifyListeners();
    return feedApiResponse;
  }

  // static updateAllLikes(UserFeedModel apiRes) async {
  //   for(int i = 0; i < apiRes.userFeed.length; ++i){
  //     AppGlobalProvider.isPostLikeByMe[apiRes.userFeed[i].userPosts.id.toString()] = apiRes.userFeed[i].userPosts.isLiked;
  //   }
  // }

  addMore() async {
    pageNo++;
    await getLimitedPost();
    notifyListeners();
  }

  getLimitedPost() async {
    await postRepo.getMyFeed(pageNo: pageNo, limit: limit).then((value) {
      feedApiResponse!.userFeed.addAll(value!.userFeed);
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    notifyListeners();
    return feedApiResponse;
  }

  Future getUserProfileData(String id) async {}

  Future reportPost(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value) {
      if (value == '200') {
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
  }

  // ----------------------- Comment API Call ---------------------------//
  Future reportComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value) {
      if (value == '200') {
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
  }

  Future editComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value) {
      if (value == '200') {
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
  }

  Future deleteComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value) {
      if (value == '200') {
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
  }
}
