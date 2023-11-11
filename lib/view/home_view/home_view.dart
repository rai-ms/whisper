import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/routes/navigate_route.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';
import 'package:whisper/view/post_view/post_view.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import '../../components/app_text_form_field.dart';
import '../../components/utility_helper.dart';
import '../../model/response.dart';
import '../../utils/app_helper/app_style.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';
import '../../view_model/global_provider/global_provider.dart';
import '../../view_model/post_view_model/post_view_model.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Future<bool> _willPopCallback() async {
  //   if (pageViewNumber != 0) {
  //     final AppGlobalProvider appGlobalProvider = Provider.of(context)<AppGlobalProvider>();;
  //     pageViewNumber = 0;
  //     debugPrint("WillPop called page set to 0");
  //     appGlobalProvider.pageController.jumpToPage(0);
  //     debugPrint("Set State called");
  //     setState(() {
  //
  //     });
  //
  //     return false;
  //   } else {
  //     // If already at page 0, close the app
  //     if (Platform.isAndroid) {
  //       // For Android, use this code to exit the app
  //       SystemNavigator.pop();
  //     } else if (Platform.isIOS) {
  //       // For iOS, use this code to exit the app
  //       exit(0);
  //     }
  //     return false; // Return false to prevent popping the route
  //   }
  // }

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
          title: Row(
            children: [
              // sizedBox(wid: 20),
              Expanded(
                flex: 10,
                child: Consumer<AppGlobalProvider>(
                    builder: (context, provider, child) {
                  return InkWell(
                      onTap: () {
                        if (pageViewNumber != 3) {
                          provider.setPage(3);
                        }
                      },
                      child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(100)),
                          // child: ClipOval(child: CachedNetworkImage(imageUrl: dp, height: 30,width: 30,),),),),
                          child: FutureBuilder(
                            future: UserData.getProfilePic(),
                            builder: (context, snaps) {
                              return ClipOval(
                                  child: UtilityHelper.image(snaps.data ?? dp,
                                      fit: BoxFit.fill));
                            },
                          )));
                }),
              ),
              sizedBox(wid: 5),
              Expanded(
                  flex: 80,
                  child: InkWell(onTap: () {
                    Navigator.pushNamed(context, RouteName.addPostView);
                  }, child: Consumer<AppGlobalProvider>(
                      builder: (context, provider, child) {
                    return AppTextFormField(
                      cont: AppGlobalProvider.controller,
                      style: AppStyle.whiteMedium16,
                      onChanged: AppGlobalProvider.onChanged,
                      enableBorderColor: AppColors.white,
                      enable: false,
                      prefixIcon: const Icon(
                        null,
                        color: AppColors.white,
                      ),
                      disableBorderColor: AppColors.white,
                      hintText: "What's in your mind??",
                      hintStyle: AppStyle.greyRegular20,
                      obscureText: false,
                    );
                  }))),
              sizedBox(wid: 5),
              Expanded(
                  flex: 10,
                  child: InkWell(onTap: () {
                    if (pageViewNumber != 3) {
                      Navigator.pushNamed(context, RouteName.addPostView);
                    } else {
                      Navigator.pushNamed(context, RouteName.settingsView);
                    }
                  }, child:
                      Consumer<AppGlobalProvider>(builder: (context, pr, ch) {
                    return Icon(
                      pageViewNumber != 3
                          ? FontAwesomeIcons.images
                          : FontAwesomeIcons.gear,
                    );
                  }))),
              // sizedBox(wid: 20),
            ],
          ),
        ),
        body: Center(
          child: Container(
            height: getFullHeight(context) - 110,
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                // FutureBuilder(future: UtilityHelper.isInternet(), builder: (context, snapshot){
                //   if(snapshot.data == true){
                //     return ;
                //   }
                //   else {
                //         return Expanded(
                //           flex: 11,
                //           child: Image.asset(AppImages.dog1),
                //         );
                //       }
                //     })
                Expanded(
                  flex: 11,
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
                          PostView(key: PageStorageKey('page0')),
                          NotificationView(key: PageStorageKey('page1'),),
                          SearchUser(key: PageStorageKey('page2'),),
                          ProfileView(key: PageStorageKey('page3')),
                        ],
                      ),
                    );
                  }),
                ),
                // const Flexible(
                //   flex: 1,
                //   child: AppBottomNavigationBar()),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
