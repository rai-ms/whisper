import 'package:flutter/cupertino.dart';
import '../../global/global.dart';
import '../../repository/home_repo/get_my_posts_repo.dart';

class PostViewModel extends ChangeNotifier
{
  getAllPost() async {
    // API call code will be here
    try
    {
      return GetMyPostRepo.getMyPost();
    }
    catch (e){
      debugPrint("Error");
      // return generateDummyPosts();
    }
  }
}