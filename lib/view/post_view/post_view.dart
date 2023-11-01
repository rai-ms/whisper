import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
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

  UserFeedModel? feedApiResponse;
  final ScrollController postPageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("Reloading Post View.......");
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => PostViewApiResponseProvider())],
     child: RefreshIndicator(
       onRefresh:  () async {
         setState(() {

         });
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
                         future: PostViewModel.getAllPost(),
                         builder: (context, snapshot) {
                             feedApiResponse = snapshot.data;
                             if(snapshot.connectionState == ConnectionState.waiting) {
                               return Center(
                                   child: Container(
                                     height: 490,
                                     width:  350,
                                     decoration: BoxDecoration(
                                       color: AppColors.grey,
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                   )
                               );
                             }
                             else if(snapshot.hasError) {
                               return const Center(child: Text (AppStrings.error));
                             }
                             else if(snapshot.hasData) {
                               return ListView.builder (
                                 key: const PageStorageKey<String>(StoragePathKey.postViewPath),
                                 controller: postPageController,
                                 itemBuilder: (context, index){
                                   return PostCard(post: feedApiResponse!.userFeed[index].userPosts, userData: feedApiResponse!.userFeed[index].userData,);
                                 },
                                 itemCount: feedApiResponse!.userFeed.length,
                               );
                             }
                             else {
                               return const Center(child: Text(AppStrings.noDataFound));
                             }
                           }
                       );
                     }
                 ),
               ),
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
