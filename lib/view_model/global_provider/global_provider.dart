import 'package:flutter/cupertino.dart';
import 'package:whisper/utils/deBouncer/deBouncer.dart';
import 'package:whisper/view/notification_view/notification_view.dart';
import 'package:whisper/view/post_view/post_view.dart';
import 'package:whisper/view/profile_view/profile_view.dart';
import 'package:whisper/view/search_user_view/search_user_view.dart';
import '../../global/global.dart';
import '../../model/response.dart';
import '../../model/search_user.dart';
import '../../repository/search_repo/search_repo.dart';

class AppGlobalProvider extends ChangeNotifier {
  static TextEditingController controller = TextEditingController();
  static DeBouncer deBouncer = DeBouncer(milliseconds: 200);
  static onChanged(String val) async {
    deBouncer.run(() async {
      await searchUser(username: val).then((value) {});
    });
  }

  static SearchResponseUserData? searchResponseUserData;
  static final SearchRepository searchRepository = SearchRepository();
  static Future searchUser({required String username}) async {
    await searchRepository
        .searchUser(SearchUserPayload(username: username))
        .then((value) {
      // debugPrint("Response received in view model email is:${value!.data.email}");
      // debugPrint("Response received in view model username is:${value!.data.username}");
      searchResponseUserData = value;
    }).onError((error, stackTrace) {
      debugPrint("Error in Search user View Model :$error");
    });
  }

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final PageStorageBucket profileStorageBucket = PageStorageBucket();
  // final ScrollController postPageController = ScrollController();

  // Page 0 = HomePage
  // Page 1 = Notification Page
  // Page 2 = Search User
  // Page 3 = User Profile Page

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1,
  );

  // void scrollListner(){
  //   postPageController.addListener(() {
  //     if(postPageController.position.pixels - postPageController.position.maxScrollExtent <= 700){
  //       debugPrint("Reload Called");
  //     }
  //   });
  // }

  setPage(val) {
    pageViewNumber = val;
    pageController.animateToPage(val,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    notifyListeners();
  }

  List<Widget> views = [
    const PostView(),
    const NotificationView(),
    const SearchUser(),
    const ProfileView(),
  ];

  List<Post> postList = [];

  // getAllPost() {
  //   if(postList.isNotEmpty) return postList;
  //   return generateDummyPosts();
  // }

  getUserProfile(String id) async {}

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  static Map<String, bool> isPostLikeByMe = {"":false};

}
