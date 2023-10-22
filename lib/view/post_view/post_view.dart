import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/view/post_view/widgets/post_card.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import '../../global/global.dart';
import '../../utils/app_helper/app_keys.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {


  List<dynamic> postList = [];
  final ScrollController postPageController = ScrollController();

  @override
  void initState() {
    super.initState();
    // postPageController.addListener(() {
    //   if( postPageController.position.maxScrollExtent - postPageController.position.pixels <= 800 ){
    //     debugPrint("PostList length ${postList.length}");
    //     postList.addAll(generateDummyPosts());
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColorLight,
        child: Column(
          children:
          [
            Expanded(
              flex: 95,
              child: Consumer<AppGlobalProvider>(
                builder: (context, provider, child) {
                  postList = provider.getAllPost();
                  return ListView.builder(
                    key: const PageStorageKey<String>(StoragePathKey.postViewPath),
                    controller: postPageController,
                    itemBuilder: (context, index) {
                      return PostCard(post: postList[index]);
                    },
                    itemCount: postList.length,
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
