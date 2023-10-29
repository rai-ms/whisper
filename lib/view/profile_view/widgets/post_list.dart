import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
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
    super.build(context);
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
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 204, 199, 199),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                      child: UtilityHelper.image(widget.postList[index].url)),
                ),
              ),
              sizedBox(hei: 3),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.thumb_up_alt_outlined),
                        Text(widget.postList[index].likeCount.toString(), style: AppStyle.primaryColorDarkMedium14(context),),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.comment),
                        Text(widget.postList[index].commentCount.toString(), style: AppStyle.primaryColorDarkMedium14(context),),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    ) ;
  }

  @override
  bool get wantKeepAlive => true;
}
