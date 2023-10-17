import 'package:flutter/cupertino.dart';
import 'package:whisper/view/add_post_view/add_post_view.dart';
import 'package:whisper/view/notification_view/notification_view.dart';
import 'package:whisper/view/post_view/post_view.dart';
import 'package:whisper/view/profile_view/profile_view.dart';
import 'package:whisper/view/search_user_view/search_user_view.dart';
import '../../global/global.dart';
import '../../model/post_model.dart';

class AppGlobalProvider extends ChangeNotifier
{
  // Page 0 = HomePage
  // Page 1 = Notification Page
  // Page 2 = Post Add page
  // Page 3 = Search User
  // Page 4 = User Profile Page
  int _page = 0;
  int get page => _page;

  set page (val){
    _page = val;
    notifyListeners();
  }

  List<Widget> views = [const PostView(), const NotificationView(), const AddPostView(), const SearchUser(), const ProfileView(),];

  getView(){
    return views[page];
  }

  List<Post> postList = [];

  getAllPost(){
    if(postList.isNotEmpty) return postList;
    return generateDummyPosts();
  }

  getUserProfile(String id) async {

  }
}