import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_bottom_sheet.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/components/loading_tile.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/like.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/utils.dart';
import 'package:whisper/view/post_view/widgets/expandable_text.dart';
import 'package:whisper/view_model/post_details_provider/post_details_provider.dart';
import '../../components/app_dialog.dart';
import '../../utils/app_helper/app_style.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({super.key, required this.postId, this.isLiked = false});

  final bool isLiked;
  final String postId;

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  @override
  void initState() {
    super.initState();
    loadLocal();
    debugPrint("Like status is${widget.isLiked}");
    debugPrint("Post Id is${widget.postId}");
  }

  loadLocal () async {
    PostDetailsProvider.postId = widget.postId;
    PostDetailsProvider.isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostDetailsProvider(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            sizedBox(hei: 10),
            Expanded(
              child: Consumer<PostDetailsProvider>(builder: (context, pr, ch) {
                return Column(
                  children: [
                    Expanded(
                      flex: 90,
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                          future: pr.getPostDetails(),
                          builder: (context, snap) {
                              return Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        sizedBox(wid: 10),
                                        if (pr.apiResponseUserDataModel == null) const CircleAvatar(radius: 40,),
                                        if (pr.apiResponseUserDataModel != null) ClipOval(
                                          child: UtilityHelper.image( pr.apiResponseUserDataModel?.data[0].profilePic, fit: BoxFit.fill,height: 60,
                                            width: 60,),
                                        ),
                                        sizedBox(wid: 10),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            if (pr.apiResponsePostModel == null) const Text("Loading..."),
                                            if (pr.apiResponsePostModel != null) Text(pr.apiResponseUserDataModel!.data[0].username.toString() ?? "Loading..."),
                                            if (pr.apiResponsePostModel == null) const Text("Loading..."),
                                            if (pr.apiResponsePostModel != null) Text(Utils.formatDateTime(pr.apiResponsePostModel!.data[0].createdAt.toString())),
                                          ],
                                        ),
                                        Expanded(child: sizedBox()),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                                                    child: AppDialog( dialogWidget: Padding(
                                                      padding: const EdgeInsets.all(1.2),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: AppTextFormField(cont: pr.editPostController, obscureText: false, isPrefixIconExist: false, disableBorderColor: AppColors.white, enableBorderColor: AppColors.white, style: AppStyle.whiteMedium16, maxLines: 3, contentPadding: 10,),
                                                          ),
                                                          sizedBox(hei: 10),
                                                          AppRoundedButton(onTap: (){
                                                            Navigator.pop(context);
                                                            pr.editPostCaption();
                                                          }, title: AppStrings.save, borderColor: AppColors.white, borderWidth: 2, textStyle: AppStyle.whiteMedium16,),
                                                        ],
                                                      ),
                                                    ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        // if(pr.apiResponseUserDataModel != null) FutureBuilder(
                                        //   future: pr.getUserName(),
                                        //   builder: (context, snap) {
                                        //     // if(snap.hasData && snap.data == pr.apiResponseUserDataModel!.data[0].username){
                                        //     //   return IconButton(
                                        //     //       onPressed: () {
                                        //     //         showDialog(
                                        //     //             context: context,
                                        //     //             builder: (context) {
                                        //     //               return Dialog(
                                        //     //                 shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                                        //     //                 child: AppDialog( dialogWidget: Padding(
                                        //     //                   padding: const EdgeInsets.all(1.2),
                                        //     //                   child: Column(
                                        //     //                     children: [
                                        //     //                       TextFormField(),
                                        //     //                       AppRoundedButton(onTap: (){
                                        //     //                         pr.editPostCaption();
                                        //     //                       }, title: AppStrings.save),
                                        //     //                     ],
                                        //     //                   ),
                                        //     //                 ),
                                        //     //                 ),
                                        //     //               );
                                        //     //             });
                                        //     //       },
                                        //     //       icon: const Icon(Icons.edit),
                                        //     //   );
                                        //     // }
                                        //     // else {
                                        //     //   return sizedBox();
                                        //     // }
                                        //     return IconButton(
                                        //       onPressed: () {
                                        //         showDialog(
                                        //             context: context,
                                        //             builder: (context) {
                                        //               return Dialog(
                                        //                 shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                                        //                 child: AppDialog( dialogWidget: Padding(
                                        //                   padding: const EdgeInsets.all(1.2),
                                        //                   child: Column(
                                        //                     mainAxisAlignment: MainAxisAlignment.center,
                                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                                        //                     children: [
                                        //                       Padding(
                                        //                         padding: const EdgeInsets.all(8.0),
                                        //                         child: AppTextFormField(cont: pr.editPostController, obscureText: false, isPrefixIconExist: false, disableBorderColor: AppColors.white, enableBorderColor: AppColors.white, style: AppStyle.whiteMedium16, maxLines: 3, contentPadding: 10,),
                                        //                       ),
                                        //                       sizedBox(hei: 10),
                                        //                       AppRoundedButton(onTap: (){
                                        //                         pr.editPostCaption();
                                        //                       }, title: AppStrings.save, borderColor: AppColors.white, borderWidth: 2, textStyle: AppStyle.whiteMedium16,),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //                 ),
                                        //               );
                                        //             });
                                        //       },
                                        //       icon: const Icon(Icons.edit),
                                        //     );
                                        //   }
                                        // ),
                                        sizedBox(wid: 10),
                                      ],
                                    ),
                                    sizedBox(hei: 10),
                                    if(pr.apiResponsePostModel != null) Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        sizedBox(wid: 10),
                                        Expanded(child: Text(pr.apiResponsePostModel!.data[0].caption)),
                                      ],
                                    ),
                                    sizedBox(hei: 10),
                                    if (pr.apiResponseUserDataModel == null) Container (
                                        height: 280,
                                        width: getFullWidth(context),
                                        color: AppColors.greyShade,
                                      ),
                                    if (pr.apiResponseUserDataModel != null) SizedBox (
                                        height: 300,
                                        child: UtilityHelper.image(pr.apiResponsePostModel!.data[0].url, width: getFullWidth(context), fit: BoxFit.fill)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColorLight,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).primaryColorDark, blurRadius: 5, spreadRadius: 0)
                                            ],
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  pr.likeThisPost();
                                                },
                                                onLongPress: () async {
                                                  // await pr.getLikeList(widget.postId);
                                                  showLikeList();
                                                },
                                                child: Column(
                                                  children: [
                                                    if(pr.apiResponsePostModel != null) Icon(pr.apiResponsePostModel!.data[0].isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp, color: Theme.of(context).primaryColorDark,),
                                                    if(pr.apiResponsePostModel == null) Icon(FontAwesomeIcons.thumbsUp, color: Theme.of(context).primaryColorDark,),
                                                    // Icon(PostDetailsProvider.isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                    //   color: Theme.of(context).primaryColorDark,
                                                    // ),
                                                    Text("${pr.apiResponsePostModel == null ? "0" : pr.apiResponsePostModel!.data[0].likeCount}"),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                    Icon(FontAwesomeIcons.commentDots, color: Theme.of(context).primaryColorDark,
                                                  ),
                                                  Text("${pr.apiResponsePostModel == null ? "0" : pr.apiResponsePostModel!.data[0].commentCount}"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                    Icon(FontAwesomeIcons.share, color: Theme.of(context).primaryColorDark,
                                                  ),
                                                  const Text("0")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    sizedBox(hei: 10),
                                  ],
                                ),
                                Row(
                                  children: [
                                    sizedBox(wid: 10),
                                    Text("Comments", style: AppStyle.primaryColorDarkBold20(context),),
                                  ],
                                ),
                                if(pr.resCommentSpecificPost != null) Column(
                                  children: [
                                     if(pr.resCommentSpecificPost!.data!.comments!.isEmpty) Text("No Comments Found..", style: AppStyle.primaryColorDarkMedium14(context),),
                                     if(pr.resCommentSpecificPost!.data!.comments!.isNotEmpty) ...List.generate(
                                        pr.resCommentSpecificPost!.data!.comments!.length,
                                        (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: ClipOval(
                                                    child: UtilityHelper.image(pr.resCommentSpecificPost!.data!.comments![index].user.profilePic.toString()),
                                                  )),
                                                sizedBox(wid: 5),
                                                Expanded(
                                                  flex: 90,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: const BoxConstraints(minHeight: 60),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.grey,
                                                            borderRadius: BorderRadius.circular(12)),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            sizedBox(wid: 5),
                                                            Expanded(
                                                              flex: 90,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 8.0),
                                                                    child: Text(pr.resCommentSpecificPost!.data!.comments![index].user.username),
                                                                  ),
                                                                  Container(
                                                                    constraints:const BoxConstraints(maxWidth: 450,minWidth:300, minHeight: 40,),
                                                                    padding: const EdgeInsets.only(left: 10),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.white,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(pr.resCommentSpecificPost!.data!.comments![index].comment, style: AppStyle.blackMedium16,),
                                                                      ],
                                                                    )),
                                                                  sizedBox(hei: 4),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(pr.resCommentSpecificPost! .data!.comments![index].user.email),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: PopupMenuButton(
                                                    icon: const Icon(Icons.more_vert),
                                                    itemBuilder: (BuildContext context) {
                                                      return [
                                                        // if(pr.res!.data!.comments?[index].user.username == username) PopupMenuItem(
                                                        //   value: "edit",
                                                        //   child: const Text("Edit comment"),
                                                        //   onTap: (){
                                                        //     // pr.editMyComment(context: context, editOn: widget.comments![index].comment,commentID:  widget.comments![index].id);
                                                        //   },
                                                        // ),
                                                        if (pr.resCommentSpecificPost!.data!.comments?[index].user.id == PostDetailsProvider.userId) PopupMenuItem(
                                                            value: "delete",
                                                            child: const Text( "Delete comment"),
                                                            onTap: () {
                                                              pr.deleteMyComment( commentId: pr.resCommentSpecificPost!.data!.comments?[index].id.toString() ?? "", context: context);
                                                            },
                                                          ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                ),
                                if (pr.resCommentSpecificPost == null) const LoadingWidgetTile(count: 3,)
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                          sizedBox(wid: 10),
                          Expanded(
                            flex: 8,
                            child: AppTextFormField(
                              obscureText: false,
                              cont: pr.controller,
                              isPrefixIconExist: false,
                              contentPadding: 10,
                            ),
                          ),
                          sizedBox(wid: 10),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  pr.sendComment(pr.apiResponsePostModel!.data[0].userId ?? "");
                                },
                                child: const Icon(Icons.send)),
                          ),
                          sizedBox(wid: 10),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            sizedBox(hei: 10),
          ],
        ),
      ),
    );
  }

  showLikeList() async {
    await showModalBottomSheet(context: context, builder: (context){
      return SizedBox(
        child: Consumer<PostDetailsProvider>(
          builder: (context, pr, ch) {
            return FutureBuilder<ApiResponseLikesData?>(
              future: pr.getLikeList(widget.postId),
              builder: (context, snap) {
                if(snap.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 28.0, left: 25, right: 25),
                    child: ListView.builder(itemCount: snap.data!.data.likes.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                              future: pr.getProfileDetails(snap.data!.data.likes[index].user.id),
                              builder: (context, snaps) {
                                  return Row(
                                    children: [
                                      snaps.hasData? ClipOval(child: UtilityHelper.image(snaps.data!.data[0].profilePic, height: 50, width: 50, fit: BoxFit.fill)) : const CircleAvatar(radius: 30,backgroundColor: AppColors.greyShade,),
                                      sizedBox(wid: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snaps.hasData? "${snaps.data!.data[0].fullName} 👍🏻!" : "Loading", style: AppStyle.primaryColorDarkMedium20(context),),
                                          Text(snaps.hasData? snaps.data!.data[0].email: "Loading..", style: AppStyle.primaryColorDarkMedium14(context),),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                      },
                    ),
                  );
                }
                else {
                  return  SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 28.0, left: 25,),
                    child: Row(
                      children: [
                        LoadingWidgetTile(count: 10,width: getFullWidth(context)*.7,),
                      ],
                    ),
                  ));
                }
              }
            );
          }
        ),
      );
    });
  }

}
