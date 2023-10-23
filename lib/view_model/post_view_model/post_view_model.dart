import 'package:flutter/cupertino.dart';
import 'package:whisper/model/feed_response_model.dart';
import '../../repository/post_repo/post_repo.dart';

class PostViewModel extends ChangeNotifier
{

  static List<FeedApiResponse>? postList;

  static PostRepository postRepo = PostRepository();

  static Future<List<FeedApiResponse>?> getAllPost() async {

    List<FeedApiResponse>? postList;
    await postRepo.getMyFeed().then((value){
      postList = value!;
    }).onError((error, stackTrace){});
    return postList;
  }
}