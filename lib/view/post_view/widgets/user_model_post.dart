import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../../utils/utils.dart';
import '../../../view_model/post_view_model/post_view_model.dart';

class UserRowPost extends StatefulWidget {
  const UserRowPost(
      {super.key,
      this.postedByUserImage,
      this.postDate,
      this.postedBy,
      this.postId,
      this.postedById,
      this.profilePic});

  final String? postedByUserImage;
  final String? postDate;
  final String? postedBy;
  final String? postId;
  final String? postedById;
  final String? profilePic;

  @override
  State<UserRowPost> createState() => _UserRowPostState();
}

class _UserRowPostState extends State<UserRowPost> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  String? userId;

  loadData() async {
    userId = await UserData.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
                child: UtilityHelper.image(widget.profilePic ?? dp,
                    height: 40, width: 40, fit: BoxFit.fill)),
            sizedBox(wid: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.postedBy ?? "",
                  style: AppStyle.primaryColorDarkMedium(context),
                ),
                Text(
                  widget.postDate == null
                      ? postTime
                      : Utils.formatDateTime(widget.postDate!),
                  style: AppStyle.primaryColorDarkMedium14(context),
                ),
              ],
            ),
          ],
        ),
        Consumer<PostViewModel>(builder: (context, pr, ch) {
          return PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                if (userId != widget.postedById)
                  PopupMenuItem(
                    value: "report",
                    child: const Text(AppStrings.reportPost),
                    onTap: () {
                      pr.reportPost(widget.postId!);
                    },
                  ),
                if (userId == widget.postedById)
                  PopupMenuItem(
                    value: "edit",
                    child: const Text("Edit Post"),
                    onTap: () {
                      // pr.reportPost(widget.postId!);
                    },
                  ),
                if (userId == widget.postedById)
                  PopupMenuItem(
                    value: "delete",
                    child: const Text("Delete Post"),
                    onTap: () {
                      PostRepository().deletePost(widget.postId!).then((value) {
                        setState(() {});
                      });
                    },
                  ),
              ];
            },
          );
        })
      ],
    );
  }
}
