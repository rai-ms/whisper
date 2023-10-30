import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/feed_response_model.dart';
import '../../repository/post_repo/post_repo.dart';

class PostViewModel extends ChangeNotifier
{

  static UserFeedModel? feedApiResponse;


  static PostRepository postRepo = PostRepository();


  static Future<UserFeedModel?> getAllPost() async {
    await postRepo.getMyFeed().then((value){
      feedApiResponse = value!;
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    return feedApiResponse;
  }


  static getUserProfileData(String id) async {

  }


  Future reportPost(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value){
      if(value == '200'){
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
  }

  // ----------------------- Comment API Call ---------------------------//
  Future reportComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value){
      if(value == '200'){
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
  }

  Future editComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value){
      if(value == '200'){
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
  }

  Future deleteComment(String postId) async {
    debugPrint("Report is called for:$postId");
    await PostRepository().reportPost(postId).then((value){
      if(value == '200'){
        debugPrint("Report done in view-model $value");
      }
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
  }
}