import 'package:flutter/cupertino.dart';
import 'package:whisper/components/utility_helper.dart';

import '../../../model/user_profile_response.dart';
import '../../../utils/app_helper/app_keys.dart';

class PostList extends StatefulWidget {
  const PostList({super.key, required this.postList});
  final List<UserPost> postList;
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey<String>(StoragePathKey.postListPath),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0, // Add spacing as needed.
        mainAxisSpacing: 2.0,  // Add spacing as needed.
      ),
      itemCount: widget.postList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: const Color.fromARGB(156, 204, 199, 199),
            child: UtilityHelper.image(widget.postList[index].url),
          ),
        );
      },
    ) ;
  }

  @override
  bool get wantKeepAlive => true;
}
