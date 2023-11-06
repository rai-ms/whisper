import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/feed_response_model.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view/post_view/widgets/user_model_post.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/personal_profile_view_model/api_res_provider.dart';
import '../../../components/utility_helper.dart';
import '../../../view_model/post_view_model/post_view_model.dart';
import 'expandable_text.dart';
import 'like_comment_share_bar.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post, required this.userData});
  final UserPosts post;
  final UserDatas userData;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => PostViewApiResponseProvider())],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            width: getFullWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).canvasColor,
                    blurRadius: 2,
                    spreadRadius: 1),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox(hei: 10),
                  Consumer2<AppGlobalProvider, PostViewModel> (builder: (context, pr, pr2, ch) {
                    return InkWell(
                        onTap: () async {
                          String? cUid = await UserData.getUserId();
                          if (widget.userData.id != cUid && context.mounted) {
                            Navigator.pushNamed(context, RouteName.thirdUserProfileView, arguments: {"id": widget.userData.id});
                          }
                          else {
                            pr.setPage(3);
                          }
                        },
                        child: UserRowPost(
                            postedBy: widget.userData.username,
                            postId: widget.post.id,
                            postedById: widget.post.userId,
                            postDate: widget.post.createdAt,
                            profilePic: widget.userData.profilePic));
                  }),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.postDetailsView, arguments: {
                            'postId': widget.post.id,
                            'isLiked': widget.post.isLiked
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox(hei: 12),
                        InteractiveViewer( child: UtilityHelper.image(widget.post.url, width: getFullWidth(context),)),
                        sizedBox(hei: 10),
                        // DescriptionTextWidget(text: widget.post.postDescription.toString(),),
                        ExpandableText(text: widget.post.caption.toString(),),
                        sizedBox(hei: 10),
                      ],
                    ),
                  ),
                  Consumer<PostViewApiResponseProvider>(builder: (context, apiResProvider, child) {
                    return FutureBuilder<LikeAndCommentOfApiResponse?>(
                        future: apiResProvider.getLikesAndComments(widget.post.id ?? ""),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CommentLikeShareBar(
                              comments: snapshot.data!.comments!.data!.comments!,
                              postId: widget.post.id ?? "",
                              post: widget.post,
                              likes: snapshot.data!.likes!.data.likes,
                            );
                          }
                          else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CommentLikeShareBar(
                              postId: "",
                            );
                          }
                          else if (snapshot.hasError) {
                            return const Text(AppStrings.errorOccured);
                          }
                          else {
                            return const Text(AppStrings.noDataFound);
                          }
                        });
                  }),
                  sizedBox(hei: 10),
                ],
              ),
            )),
      ),);
  }
}
