import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import '../../../components/app_dialog.dart';

class UserRowPost extends StatefulWidget {
  const UserRowPost({super.key, this.postedByUserImage, this.postDate, this.postedBy, this.postId});

  final String? postedByUserImage;
  final String? postDate;
  final String? postedBy;
  final String? postId;

  @override
  State<UserRowPost> createState() => _UserRowPostState();
}

class _UserRowPostState extends State<UserRowPost> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(child: UtilityHelper.image( widget.postedByUserImage ??  "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", height: 40, width: 40, fit: BoxFit.fill)),
            sizedBox(wid: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.postedBy ?? "Ashish Rai",style: AppStyle.primaryColorDarkMedium(context),),
                Text(widget.postDate ??  postTime,style: AppStyle.primaryColorDarkMedium14(context),),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: (){
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: AppDialog(
                  dialogWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:
                      [
                        Text("Do You Want to report on this post", style: AppStyle.whiteBold20,textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
              )
            );
          },
          child: Icon(Icons.more_vert, color: Theme.of(context).primaryColorDark,),
        )
      ],
    );
  }
}
