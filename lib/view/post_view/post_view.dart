import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/view/post_view/widgets/loading_widget_post.dart';
import 'package:whisper/view/post_view/widgets/post_card.dart';
import '../../model/feed_response_model.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../view_model/personal_profile_view_model/api_res_provider.dart';
import '../../view_model/post_view_model/post_view_model.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with AutomaticKeepAliveClientMixin {
  final ScrollController postPageController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   postPageController = new ScrollController()..addListener(_scrollListener);
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("Reloading Post View.......");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => PostViewApiResponseProvider())
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Center(
          child: Container(
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                Expanded(
                  flex: 95,
                  child: Consumer<PostViewModel>(
                    builder: (context, provider, child) {
                      return FutureBuilder<UserFeedModel?>(
                        future: provider.getAllPost(),
                        builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const LoadingPost(length: 20);
                            }
                            else if (snapshot.hasError) {
                              return const Center(
                                  child: Text(AppStrings.error));
                            }
                            else if (provider.feedApiResponse != null) {
                              return ListView.builder(
                                key: const PageStorageKey<String>(StoragePathKey.postViewPath),
                                controller: postPageController,
                                itemBuilder: (context, index) {
                                  return PostCard(
                                    post: provider.feedApiResponse!.userFeed[index].userPosts,
                                    userData: provider.feedApiResponse!.userFeed[index].userData,
                                  );
                                },
                                itemCount: provider.feedApiResponse!.userFeed.length,
                              );
                            }
                            else {
                              return const Center(
                                  child: Text(AppStrings.noDataFound));
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// For pagination
  loadMore() async {
    postPageController.addListener((){
      debugPrint("Listening....");
    });
  }

  @override
  bool get wantKeepAlive => true;
}
