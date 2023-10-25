import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/feed_response_model.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/view/post_view/widgets/user_model_post.dart';
import 'package:whisper/view_model/personal_profile_view_model/api_res_provider.dart';
import 'package:whisper/view_model/post_view_model/post_view_model.dart';
import '../../../components/utility_helper.dart';
import '../../../model/comment.dart';
import 'expandable_text.dart';
import 'like_comment_share_bar.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post, required this.userData});
  final FeedUserPost post;
  final FeedUserData userData;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
          width: getFullWidth(context),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow:  [
               BoxShadow(color: Theme.of(context).canvasColor, blurRadius: 2,spreadRadius: 1),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(hei: 10),
                UserRowPost(postedBy: widget.userData.username, postId: widget.post.id,),
                sizedBox(hei: 12),
                UtilityHelper.image(widget.post.url, width: getFullWidth(context)),
                sizedBox(hei: 10),
                // DescriptionTextWidget(text: widget.post.postDescription.toString(),),
                ExpandableText(
                  text: widget.post.caption.toString(),),
                sizedBox(hei: 10),
                // CommentLikeShareBar(comments: widget.post.),
                Consumer<PostViewApiResponseProvider>(
                    builder: (context, apiResProvider, child) {
                      return FutureBuilder<APIResponseCommentModel?>(
                          future: PostViewApiResponseProvider.getCommentsList(widget.post.id),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              // debugPrint("${snapshot.data!.comments.length}");
                              return CommentLikeShareBar(comments: snapshot.data!.data!.comments, postId: widget.post.id,);
                            }
                            else if(snapshot.connectionState == ConnectionState.waiting){
                              return CommentLikeShareBar(postId: "",);
                            }
                            else if(snapshot.hasError){
                              return const Text("Error while loading");
                            }
                            else {

                              return const Text("Data not found");
                            }
                          }
                      );
                    }
                ),
                sizedBox(hei: 10),
              ],
            ),
          )),
    );
  }
}
