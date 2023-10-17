import 'package:flutter/cupertino.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/post_model.dart';
import 'package:whisper/view/post_view/widgets/user_model_post.dart';
import '../../../components/utility_helper.dart';
import 'description_text.dart';
import 'expandable_text.dart';
import 'like_comment_share_bar.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});
  final Post post;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
          width: getFullWidth(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserRowPost(),
                sizedBox(hei: 12),
                UtilityHelper.image(widget.post.image!, width: getFullWidth(context)),
                sizedBox(hei: 10),
                // DescriptionTextWidget(text: widget.post.postDescription.toString(),),
                ExpandableText(

                  text: widget.post.postDescription.toString(),),
                sizedBox(hei: 10),
                CommentLikeShareBar(comments: widget.post.comments, likes: widget.post.likes,share: widget.post.shares,),
              ],
            ),
          )),
    );
  }
}
