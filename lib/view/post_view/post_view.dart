import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/response.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/view/post_view/widgets/post_card.dart';
import '../../model/feed_response_model.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../view_model/post_view_model/post_view_model.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with AutomaticKeepAliveClientMixin {

  List<FeedApiResponse>? postList = [];
  final ScrollController postPageController = ScrollController();
  @override
  Widget build(BuildContext context) {
    debugPrint("Reloading Post View.......");
    return Scaffold(body: Center(
      child: Container(
        color: Theme.of(context).primaryColorLight,
        child: Column(
          children: [
            Expanded(
              flex: 95,
              child: Consumer<PostViewModel>(
                  builder: (context, provider, child) {
                    // postList = provider.getAllPost() ;
                    return FutureBuilder<List<FeedApiResponse>?>(
                        future: PostViewModel.getAllPost(),
                        builder: (context, snapshot) {
                          postList = snapshot.data;
                          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: Container(height: 70, width:  300, color: AppColors.grey,));
                          }
                          else if(snapshot.hasError){
                            return const Center(child: Text("Error"));
                          }
                          else if(snapshot.hasData){
                            return ListView.builder(
                              key: const PageStorageKey<String>(StoragePathKey.postViewPath),
                              controller: postPageController,
                              itemBuilder: (context, index) {
                                return PostCard(post: postList![index].feedUserPost, userData: postList![index].feedUserData, );
                              },
                              itemCount: postList!.length,
                            );
                          }
                          else {
                            return sizedBox();
                          }
                        }
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  @override
  bool get wantKeepAlive => true;
}
