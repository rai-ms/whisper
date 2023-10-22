import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view/home_view/widgets/HomePageAppBar.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';
import 'package:whisper/view/post_view/post_view.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/home_view_view_model/post_view_model.dart';
import '../../components/app_text_form_field.dart';
import '../../components/utility_helper.dart';
import '../../model/post_model.dart';
import '../../utils/app_helper/app_style.dart';
import '../../view_model/global_provider/global_provider.dart';
import '../notification_view/notification_view.dart';
import '../profile_view/profile_view.dart';
import '../search_user_view/search_user_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {

  List<Post> postList = [];

  @override
  void initState() {
    fetchAllDummyPost();
    super.initState();

  }

  fetchAllDummyPost(){
    postList = generateDummyPosts();
    UserData.getUserAccessToken().then((value){
      debugPrint("User Data Fetched Success $value");
    }).onError((error, stackTrace){
      debugPrint("User Data Fetched Failed $error");
    });


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppBarViewModel()),
        ChangeNotifierProvider(create: (context) => PostViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title:  Row(
            children: [
              // sizedBox(wid: 20),
              Expanded(
                flex: 10,
                child: Consumer<AppGlobalProvider>(
                  builder: (context, provider, child) {
                    return InkWell(onTap: (){
                      if(pageViewNumber != 3){
                        provider.setPage(3);
                      }
                    },child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.white, width:  3),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=XnnVIAFitkUAX_luQ-r&_nc_ht=scontent.fdel72-1.fna&oh=00_AfBOBvAf8MrWfdpbU1NSzWArdT4TUuEa7jMdk6awI1ZGhw&oe=65345EA0",))));
                  }
                ),
              ),
              sizedBox(wid: 5),
              Expanded(flex: 80,child: InkWell(onTap: (){
                if(pageViewNumber != 2 ){
                  Navigator.pushNamed(context, RouteName.addPostView);
                }
              },child: Consumer<AppGlobalProvider>(
                builder: (context, provider, child) {
                  return AppTextFormField(enableBorderColor: AppColors.white, enable: pageViewNumber == 2 ? true : false, prefixIcon: Icon(pageViewNumber == 2? FontAwesomeIcons.magnifyingGlass : null, color: AppColors.white,),disableBorderColor: AppColors.white, hintText: pageViewNumber != 2? "What's in your mind??" : "Search User", hintStyle: AppStyle.greyRegular20,);
                }
              ))),
              sizedBox(wid: 5),
              Expanded(flex: 10,child: InkWell(onTap: (){
                Navigator.pushNamed(context, RouteName.addPostView);
              },child: const Icon(FontAwesomeIcons.images, ))),
              // sizedBox(wid: 20),
            ],
          ),
        ),
        body: Center(
          child: Container(
            height: getFullHeight(context),
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                // const HomePageAppBar(),
                Expanded(
                  flex: 77,
                  child: Consumer<AppGlobalProvider>(
                      builder: (context, provider, child) {
                        return PageStorage(
                          bucket: provider.pageStorageBucket,
                          child: PageView(
                            key: const PageStorageKey<String>('pathHomeView'),
                            controller: provider.pageController,
                            pageSnapping: true,
                            reverse: false,
                            allowImplicitScrolling: false,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              PostView(),
                              NotificationView(),
                              SearchUser(),
                              ProfileView(),
                            ],
                          ),
                        );
                      }
                  ),
                  // Consumer<AppGlobalProvider>(builder: (context, provider, child){
                  //   return provider.getView();
                  // }),
                ),
                const Expanded(
                    flex: 8,
                    child: AppBottomNavigationBar()),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
