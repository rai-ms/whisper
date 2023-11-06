import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import '../../../model/feed_response_model.dart';
import '../../../model/like.dart';
import '../../../utils/app_helper/app_strings.dart';
import '../../../utils/app_helper/user_data_preferences/user_data.dart';
import '../../../view_model/home_view_view_model/post_card_comment_view_model.dart';
import '../../../view_model/home_view_view_model/post_card_like_view_model.dart';

class CommentLikeShareBar extends StatefulWidget {
  const CommentLikeShareBar({super.key, this.comments, this.likes, required this.postId, this.post});
  final String postId;
  final List<APIResponseComment>? comments;
  final List<ApiResponseLike>? likes;
  // final List<Share>? share;
  final UserPosts? post;

  @override
  State<CommentLikeShareBar> createState() => _CommentLikeShareBarState();
}

class _CommentLikeShareBarState extends State<CommentLikeShareBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("${widget.comments!.length ?? empty} length of comments on this post");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikeViewModel()),
      ],
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(top: 10),
        width: getFullWidth(context),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColorDark,
                  blurRadius: 5,
                  spreadRadius: 0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer<LikeViewModel>(builder: (context, provider, child) {
              return InkWell(
                onTap: () {
                  provider.likePost(widget.postId, widget.post?.isLiked ?? false, widget.post?.userId ?? "");
                  setState(() {
                    debugPrint("DebugPrint for like");
                    widget.post!.isLiked = !widget.post!.isLiked;
                  });
                },
                onLongPress: () {
                  provider.showLikeBottomSheet(showLikeBottomSheet);
                },
                child: Row(
                  children: [
                    if (widget.post != null)
                      Column(
                        children: [
                          Icon(!widget.post!.isLiked ? FontAwesomeIcons.thumbsUp : FontAwesomeIcons.solidThumbsUp, color: Theme.of(context).primaryColorDark,),
                          Text(widget.post!.isLiked ? "You ${(widget.likes!.length - 1 == 0) ? "Only" : "and ${widget.likes!.length - 1}"}" : widget.post!.likeCount.toString(), style: AppStyle.primaryColorDarkMedium14(context),),
                        ],
                      ),
                    if (widget.post == null)
                      Column(
                        children: [
                          if (widget.post == null)
                            Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          if (widget.post == null) const Text("0"),
                        ],
                      ),
                    sizedBox(wid: 2),
                  ],
                ),
              );
            }),
            Consumer<PostCardCommentViewModel>(builder: (
              context,
              provider,
              child,
            ) {
              return InkWell(
                  onTap: () async {
                    String? myUserName = await UserData.getUserUsername();
                    showMyCommentBottomSheet(myUserName ?? "");
                  },
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.commentDots,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      sizedBox(wid: 5),
                      widget.comments != null
                          ? Text(
                              widget.post!.commentCount.toString(),
                            )
                          : const Text("0")
                    ],
                  ));
            }),
            Column(
              children: [
                Icon(
                  FontAwesomeIcons.share,
                  color: Theme.of(context).primaryColorDark,
                ),
                const Text("0")
              ],
            ),
            // Consumer<PostShareViewModel>(
            //   builder: (context, child, provider) {
            //     // debugPrint(shareCount.toString());
            //     return InkWell(
            //         onTap:(){
            //           bool isEmptyList = widget.share?.isEmpty ?? false;
            //           int length = widget.share?.length ?? 0;
            //           showModalBottomSheet(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(30)
            //               ),
            //               isScrollControlled: true,
            //               useSafeArea: true,
            //               context: context,
            //               builder: (context) => ConstrainedBox(
            //                 constraints: BoxConstraints(
            //                   minHeight: 400,
            //                   maxHeight: getFullHeight(context) * .9,
            //                 ),
            //                 child: SingleChildScrollView(
            //                   reverse: true,
            //                   child: Column(
            //                     children: [
            //                       sizedBox(hei: 20),
            //                       SizedBox(
            //                         height: 400,
            //                         child: ListView(
            //                           shrinkWrap: true,
            //                           children: [
            //                             ...List.generate(length, (index){
            //                               return Column(
            //                                 children: [
            //                                   Consumer<PostShareViewModel>(
            //                                       builder: (context, provider, child) {
            //                                         return ListTile(
            //                                           title: Row(
            //                                             children: [
            //                                               Expanded(flex: 10, child: ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),)),
            //                                             ],
            //                                           ),
            //                                           // subtitle: Padding(
            //                                           //   padding: const EdgeInsets.only(left: 25.0, top: 20),
            //                                           //   child: Column(
            //                                           //     children:
            //                                           //     [
            //                                           //       if(widget.comments![index].reply.isNotEmpty) ...List.generate(widget.comments![index].reply.length, (i){
            //                                           //         return ListTile(
            //                                           //           title: Row(
            //                                           //             crossAxisAlignment: CrossAxisAlignment.start,
            //                                           //             children: [
            //                                           //               ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),),
            //                                           //               sizedBox(wid: 5),
            //                                           //               Text(widget.comments![index].reply[i].content),
            //                                           //               const Expanded(child: SizedBox()),
            //                                           //               const Icon(Icons.more_vert),
            //                                           //             ],
            //                                           //           ),
            //                                           //         );
            //                                           //       })
            //                                           //     ],
            //                                           //   ),
            //                                           // ),
            //                                         );
            //                                       }
            //                                   ),
            //                                 ],
            //                               );
            //                             }),
            //                             if(isEmptyList) Text("No Shares Found")
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //           );
            //         } ,
            //         onLongPress: (){},
            //         child: Row(
            //           children: [
            //             Icon(FontAwesomeIcons.share, color: Theme.of(context).primaryColorDark,),
            //             sizedBox(wid: 5),
            //             if(widget.share != null) Text(widget.share!.length.toString()),
            //             if(widget.share == null) const Text("0"),
            //           ],
            //         ));
            //   }
            // ),
          ],
        ),
      ),
    );
  }

  void showLikeBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              constraints: BoxConstraints(
                minHeight: 400,
                maxHeight: getFullHeight(context) * .9,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    sizedBox(hei: 20),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              sizedBox(hei: 5),
                              ListTile(
                                leading: ClipOval(child: UtilityHelper.image(dp, height: 50, width: 50, fit: BoxFit.fill)),
                                title: Text(widget.likes![index].user.username),
                              ),
                              sizedBox(hei: 5),
                            ],
                          );
                        },
                        itemCount: widget.likes!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void showMyCommentBottomSheet(String username) {
    if (username.isEmpty) return;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              constraints: BoxConstraints(
                minHeight: 400,
                maxHeight: getFullHeight(context) * .9,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    sizedBox(hei: 20),
                    SizedBox(
                      height: 400,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Consumer<PostCardCommentViewModel>(builder: (context, pr, ch){
                            return FutureBuilder(future: pr.getAllComment(widget.postId), builder: (context, snap){
                              if(snap.hasData){
                                // debugPrint("Comment Data postId is${widget.postId}");
                              return Column(
                                children: [
                                  ...List.generate(snap.data!.data!.comments!.length, (index) => Column(
                                    children: [
                                      Consumer<PostCardCommentViewModel>(
                                          builder: (context, provider, child) {
                                            return ListTile(
                                              title: Row(
                                                children: [
                                                  ClipOval(
                                                    child: UtilityHelper.image(snap.data!.data!.comments![index].user.profilePic ?? dp, height: 50, width: 50, fit: BoxFit.fill),),
                                                  sizedBox(wid: 5),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                      child: Text(snap.data!.data!.comments![index].user.username),
                                                                    ),
                                                                    Container(
                                                                        constraints: const BoxConstraints(maxWidth: 450, minWidth: 300, minHeight: 40,),
                                                                        padding: const EdgeInsets.only(left: 10),
                                                                        decoration: BoxDecoration(
                                                                          color: AppColors.white,
                                                                          borderRadius: BorderRadius.circular(10),
                                                                        ),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(snap.data!.data!.comments![index].comment, style: AppStyle.blackMedium16,
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    sizedBox(hei: 4),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 10,
                                                                child: PopupMenuButton(
                                                                  icon: const Icon(Icons.more_vert),
                                                                  itemBuilder: (BuildContext context) {
                                                                    return [
                                                                      if (snap.data!.data!.comments![index].user.username == username) PopupMenuItem(
                                                                          value: "edit",
                                                                          child: const Text("Edit comment"),
                                                                          onTap: () {
                                                                            provider.editMyComment(
                                                                              context: context,
                                                                              editOn: snap.data!.data!.comments![index].comment,
                                                                              commentID: snap.data!.data!.comments![index].id);
                                                                          },
                                                                        ),
                                                                      if (snap.data!.data!.comments![index].user.username == username) PopupMenuItem(
                                                                          value: "delete",
                                                                          child: const Text("Delete comment"),
                                                                          onTap: () {
                                                                            provider.deleteMyComment(postId: widget.postId, commentId: snap.data!.data!.comments![index].id,context: context);
                                                                          },
                                                                        ),
                                                                      if (snap.data!.data!.comments![index].user.username != username) PopupMenuItem(
                                                                          value: "Report",
                                                                          child: const Text("Report comment"),
                                                                          onTap: () {},
                                                                        ),
                                                                    ];
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(snap.data!.data!.comments![index].user.email),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // subtitle: Padding(
                                              //   padding: const EdgeInsets.only(left: 25.0, top: 20),
                                              //   child: Column(
                                              //     children:
                                              //     [
                                              //       if(widget.comments![index].reply.isNotEmpty) ...List.generate(widget.comments![index].reply.length, (i){
                                              //         return ListTile(
                                              //           title: Row(
                                              //             crossAxisAlignment: CrossAxisAlignment.start,
                                              //             children: [
                                              //               ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),),
                                              //               sizedBox(wid: 5),
                                              //               Text(widget.comments![index].reply[i].content),
                                              //               const Expanded(child: SizedBox()),
                                              //               const Icon(Icons.more_vert),
                                              //             ],
                                              //           ),
                                              //         );
                                              //       })
                                              //     ],
                                              //   ),
                                              // ),
                                            );
                                          }),
                                    ],
                                  ))
                                ],
                              );
                              }
                              else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            });
                          },)
                          // if (widget.comments != null)
                          //   ...List.generate(widget.comments!.length, (index) {
                          //     return Column(
                          //       children: [
                          //         Consumer<PostCardCommentViewModel>(
                          //             builder: (context, provider, child) {
                          //           return ListTile(
                          //             title: Row(
                          //               children: [
                          //                 Expanded(
                          //                     flex: 10,
                          //                     child: ClipOval(
                          //                       child: UtilityHelper.image( widget.comments?[index].user.profilePic ?? dp, height: 40, width: 40),)),
                          //                 sizedBox(wid: 5),
                          //                 Expanded(
                          //                   flex: 90,
                          //                   child: Column(
                          //                     crossAxisAlignment: CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         constraints: const BoxConstraints(minHeight: 60),
                          //                         decoration: BoxDecoration(
                          //                             color: AppColors.grey,
                          //                             borderRadius: BorderRadius.circular(12)),
                          //                         child: Row(
                          //                           crossAxisAlignment: CrossAxisAlignment.center,
                          //                           children: [
                          //                             sizedBox(wid: 5),
                          //                             Expanded(
                          //                               flex: 90,
                          //                               child: Column(
                          //                                 mainAxisAlignment: MainAxisAlignment.start,
                          //                                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                                 children: [
                          //                                   Padding(
                          //                                     padding: const EdgeInsets.only(left: 8.0),
                          //                                     child: Text(widget.comments![index].user.username),
                          //                                   ),
                          //                                   Container(
                          //                                       constraints: const BoxConstraints(maxWidth: 450, minWidth: 300, minHeight: 40,),
                          //                                       padding: const EdgeInsets.only(left: 10),
                          //                                       decoration: BoxDecoration(
                          //                                         color: AppColors.white,
                          //                                         borderRadius: BorderRadius.circular(10),
                          //                                       ),
                          //                                       child: Column(
                          //                                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                                         mainAxisAlignment: MainAxisAlignment.center,
                          //                                         children: [
                          //                                           Text(widget.comments![index].comment, style: AppStyle.blackMedium16,
                          //                                           ),
                          //                                         ],
                          //                                       )),
                          //                                   sizedBox(hei: 4),
                          //                                   // InkWell(
                          //                                   //   onTap:()
                          //                                   //   {
                          //                                   //       provider.gotoReply(context, widget.comments![index].comment);
                          //                                   //   },
                          //                                   //   child: Text("Reply", style: AppStyle.blueNormal16,)),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             Expanded(
                          //                               flex: 10,
                          //                               child: PopupMenuButton(
                          //                                 icon: const Icon(Icons.more_vert),
                          //                                 itemBuilder: (BuildContext context) {
                          //                                   return [
                          //                                     if (widget
                          //                                             .comments![
                          //                                                 index]
                          //                                             .user
                          //                                             .username ==
                          //                                         username)
                          //                                       PopupMenuItem(
                          //                                         value: "edit",
                          //                                         child: const Text(
                          //                                             "Edit comment"),
                          //                                         onTap: () {
                          //                                           provider.editMyComment(
                          //                                               context:
                          //                                                   context,
                          //                                               editOn: widget
                          //                                                   .comments![
                          //                                                       index]
                          //                                                   .comment,
                          //                                               commentID: widget
                          //                                                   .comments![index]
                          //                                                   .id);
                          //                                         },
                          //                                       ),
                          //                                     if (widget.comments![index].user.username == username)
                          //                                       PopupMenuItem(
                          //                                         value:
                          //                                             "delete",
                          //                                         child: const Text(
                          //                                             "Delete comment"),
                          //                                         onTap: () {
                          //                                           provider.deleteMyComment(postId: widget.postId, commentId: widget.comments![index].id,context: context);
                          //                                         },
                          //                                       ),
                          //                                     if (widget.comments![index].user.username != username)
                          //                                       PopupMenuItem(
                          //                                         value: "Report",
                          //                                         child: const Text("Report comment"),
                          //                                         onTap: () {},
                          //                                       ),
                          //                                   ];
                          //                                 },
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       Text(widget.comments![index].user.email),
                          //                     ],
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //             // subtitle: Padding(
                          //             //   padding: const EdgeInsets.only(left: 25.0, top: 20),
                          //             //   child: Column(
                          //             //     children:
                          //             //     [
                          //             //       if(widget.comments![index].reply.isNotEmpty) ...List.generate(widget.comments![index].reply.length, (i){
                          //             //         return ListTile(
                          //             //           title: Row(
                          //             //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             //             children: [
                          //             //               ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),),
                          //             //               sizedBox(wid: 5),
                          //             //               Text(widget.comments![index].reply[i].content),
                          //             //               const Expanded(child: SizedBox()),
                          //             //               const Icon(Icons.more_vert),
                          //             //             ],
                          //             //           ),
                          //             //         );
                          //             //       })
                          //             //     ],
                          //             //   ),
                          //             // ),
                          //           );
                          //         }),
                          //       ],
                          //     );
                          //   }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Consumer<PostCardCommentViewModel>(
                          builder: (context, provider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (PostCardCommentViewModel
                                      .editComment.isNotEmpty)
                                    SizedBox(
                                      height: 20,
                                      child: Text(
                                          PostCardCommentViewModel.editComment),
                                    ),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    autofocus: true,
                                    controller: provider.commentCont,
                                    focusNode: provider.commentFocus,
                                    textAlign: TextAlign.start,
                                    onFieldSubmitted: (_) async {
                                      await provider.sendComment(
                                          postID: widget.postId,
                                          context: context, postedById:  widget.post!.userId ?? "");
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.comment,
                                          color: AppColors.blueSplashScreen,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
                                        hintText: AppStrings.writeComment,
                                        label: Text(AppStrings.comment),
                                        constraints: BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        hoverColor: AppColors.blueAccent),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  await provider.sendComment(
                                      postID: widget.postId, context: context, postedById:  widget.post!.userId ?? "");
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.black,
                                  child: Icon(
                                    FontAwesomeIcons.baseballBatBall,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              ),
            ));
  }
}
