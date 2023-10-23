import 'package:flutter/cupertino.dart';
import 'package:whisper/view/add_post_view/add_post_view.dart';
import 'package:whisper/view/notification_view/notification_view.dart';
import 'package:whisper/view/post_view/post_view.dart';
import 'package:whisper/view/profile_view/profile_view.dart';
import 'package:whisper/view/search_user_view/search_user_view.dart';
import '../../global/global.dart';
import '../../model/post_model.dart';
import '../../model/response.dart';

class AppGlobalProvider extends ChangeNotifier
{

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final PageStorageBucket profileStorageBucket = PageStorageBucket();
  // final ScrollController postPageController = ScrollController();

  // Page 0 = HomePage
  // Page 1 = Notification Page
  // Page 2 = Search User
  // Page 3 = User Profile Page

  PageController pageController = PageController(initialPage: 0, keepPage: false, viewportFraction: 1,);

  // void scrollListner(){
  //   postPageController.addListener(() {
  //     if(postPageController.position.pixels - postPageController.position.maxScrollExtent <= 700){
  //       debugPrint("Reload Called");
  //     }
  //   });
  // }

   setPage (val) {
    pageViewNumber = val;
    pageController.animateToPage(val, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    notifyListeners();
  }

  List<Widget> views = [const PostView(), const NotificationView(), const SearchUser(), const ProfileView(),];

  List<Post> postList = [];

  // getAllPost() {
  //   if(postList.isNotEmpty) return postList;
  //   return generateDummyPosts();
  // }

  getUserProfile(String id) async {

  }

}