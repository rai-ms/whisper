import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/view/home_view/widgets/HomePageAppBar.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/home_view_view_model/post_view_model.dart';
import '../../model/post_model.dart';
import '../../view_model/global_provider/global_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Post> postList = [];

  @override
  void initState() {
    fetchAllDummyPost();
    super.initState();

  }

  fetchAllDummyPost(){
    postList = generateDummyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppBarViewModel()),
        ChangeNotifierProvider(create: (context) => PostViewModel()),
      ],
      child:  Scaffold(
        body: Center(
          child: Container(
            height: getFullHeight(context),
            color: AppColors.white,
            child: Column(
              children: [
                const HomePageAppBar(),
                Expanded(
                  flex: 77,
                  child: Consumer<AppGlobalProvider>(builder: (context, provider, child){
                    return provider.getView();
                  }),
                ),
                // Expanded(
                //   flex: 77,
                //   child: Container(
                //     color: AppColors.white,
                //     child: ListView.builder(
                //       itemBuilder: (context, index) {
                //         return PostCard(post: postList[index]);
                //       },
                //       itemCount: postList.length,
                //     ),
                //   ),
                // ),
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
}
