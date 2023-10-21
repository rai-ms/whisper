import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/view/post_view/widgets/post_card.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';

import '../../model/post_model.dart';
import '../../utils/app_helper/app_color.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<Post> postList = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColorLight,
        child: Consumer<AppGlobalProvider>(
          builder: (context, provider, child) {
            postList = provider.getAllPost();
            return ListView.builder(
              key: const PageStorageKey<String>('notificationPath'),
              itemBuilder: (context, index) {
                return PostCard(post: postList[index]);
              },
              itemCount: postList.length,
            );
          }
        ),
      ),
    );
  }
}
