import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import '../../../model/comment.dart';
import '../../../model/like.dart';
import '../../../model/share.dart';
import '../../../utils/app_helper/app_strings.dart';
import '../../../view_model/home_view_view_model/post_card_comment_view_model.dart';
import '../../../view_model/home_view_view_model/post_card_like_view_model.dart';
import '../../../view_model/home_view_view_model/share_post_view_model.dart';

class CommentLikeShareBar extends StatefulWidget {
  const CommentLikeShareBar({super.key, this.comments, this.likes, this.share});

  final List<Comment>? comments;
  final List<Like>? likes;
  final List<Share>? share;
  @override
  State<CommentLikeShareBar> createState() => _CommentLikeShareBarState();
}

class _CommentLikeShareBarState extends State<CommentLikeShareBar> {

  bool isLiked = false;
  int likeCount = 1;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> LikeViewModel() ),
    ], child: Container(
      height: 60,
      padding: const EdgeInsets.only(top: 10),
      width: getFullWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade100)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer<LikeViewModel>(
            builder: (context, provider, child) {
              return InkWell(
                onTap:(){
                  isLiked = !isLiked;
                  provider.notifyListeners();
                  likeCount = widget.likes!.length;
                  debugPrint(widget.likes![0].toJson().toString());
                } ,
                onLongPress: (){
                  provider.showLikeBottomSheet(showLikeBottomSheet);
                },
                onHover: (bool isHoverOn){},
                child: Row(
                  children: [
                    Icon(!isLiked ? FontAwesomeIcons.thumbsUp :FontAwesomeIcons.solidThumbsUp , color: AppColors.blueSplashScreen,),
                    sizedBox(wid: 5),
                    Text(!isLiked ?widget.likes!.length.toString():( widget.likes!.length+ 1).toString()),
                  ],
                ),
              );
            }
          ),
          Consumer<PostCardCommentViewModel>(
            builder: (context, child, provider) {
              return InkWell(
                  onTap:(){
                    showModalBottomSheet(
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
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      ...List.generate(widget.comments!.length, (index){
                                        return Column(
                                          children: [
                                            Consumer<PostCardCommentViewModel>(
                                              builder: (context, provider, child) {
                                                return ListTile(
                                                  title: Row(
                                                    children: [
                                                      Expanded(flex: 10, child: ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),)),
                                                      sizedBox(wid: 5),
                                                      Expanded(
                                                        flex: 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              constraints: const BoxConstraints(
                                                                minHeight: 60
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.grey,
                                                                borderRadius: BorderRadius.circular(12)
                                                              ),
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
                                                                          child: Text(widget.comments![index].commentBy),
                                                                        ),
                                                                        Container(
                                                                          constraints: const BoxConstraints(
                                                                            maxWidth: 450,
                                                                            minWidth: 300,
                                                                            minHeight: 40,
                                                                          ),
                                                                          padding: const EdgeInsets.only(left: 10),
                                                                          decoration: BoxDecoration(
                                                                            color: AppColors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                          ),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(widget.comments![index].content, style: AppStyle.blackNormal13,),
                                                                            ],
                                                                          )),
                                                                        sizedBox(hei: 4),
                                                                        // InkWell(
                                                                        //   onTap:()
                                                                        //   {
                                                                        //       provider.gotoReply(context, widget.comments![index].content);
                                                                        //   },
                                                                        //   child: Text("Reply", style: AppStyle.blueNormal16,)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 10,
                                                                    child: InkWell(
                                                                        onTap:(){
                                                                          _showCommentPopupMenu(context);
                                                                        },
                                                                        child: const Icon(Icons.more_vert)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(widget.comments![index].createdAt),
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
                                              }
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Consumer<PostCardCommentViewModel>(builder: (context, provider, child) {
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
                                              // if(provider.replyText.isNotEmpty) Container(
                                              //   height: 20,
                                              //   child: Text(provider.replyText),
                                              // ),
                                              TextFormField(
                                                textInputAction: TextInputAction.next,
                                                autofocus: true,
                                                controller: provider.commentCont,
                                                focusNode: provider.commentFocus,
                                                textAlign: TextAlign.start,
                                                onFieldSubmitted: (_) {
                                                  provider.sendComment();
                                                },
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                      FontAwesomeIcons.comment,
                                                      color: AppColors.blueSplashScreen,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(20)),
                                                        borderSide:
                                                        BorderSide(width: 2, color: AppColors.black)),
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
                                        const Expanded(
                                          flex: 2,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: AppColors.black,
                                            child: Icon(FontAwesomeIcons.baseballBatBall, color: AppColors.white,),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
                              ],
                            ),
                          ),
                      )
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.commentDots, color: AppColors.blueSplashScreen,),
                      sizedBox(wid: 5),
                      Text(widget.comments!.length.toString())
                    ],
                  ));
            }
          ),
          Consumer<PostShareViewModel>(
            builder: (context, child, provider) {
              // debugPrint(shareCount.toString());
              return InkWell(
                  onTap:(){
                    bool isEmptyList = widget.share?.isEmpty ?? false;
                    int length = widget.share?.length ?? 0;
                    showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => ConstrainedBox(
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
                                      ...List.generate(length, (index){
                                        return Column(
                                          children: [
                                            Consumer<PostShareViewModel>(
                                                builder: (context, provider, child) {
                                                  return ListTile(
                                                    title: Row(
                                                      children: [
                                                        Expanded(flex: 10, child: ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=AnRkGOVWizoAX-O4dEW&_nc_ht=scontent.fdel72-1.fna&oh=00_AfDmo8PgOQL52u6ewobm5mrTzYq-aIdjC4_LjLOfup1SnA&oe=65326460", height: 40, width: 40),)),
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
                                                }
                                            ),
                                          ],
                                        );
                                      }),
                                      if(isEmptyList) Text("No Shares Found")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  } ,
                  onLongPress: (){

                  },
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.share, color: AppColors.blueSplashScreen,),
                      sizedBox(wid: 5),
                      if(widget.share != null) Text(widget.share!.length.toString()),
                      if(widget.share == null) const Text("0"),
                    ],
                  ));
            }
          ),
        ],
      ),
    ),);
  }

  void _showCommentPopupMenu(BuildContext context) {
    final RenderBox overlay =
    Overlay.of(context)!.context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        const Rect.fromLTWH(400, 500, 10, 10),
        Offset.zero & overlay.size,
      ),
      items: [
        const PopupMenuItem(
          child: Text("Report comment"),
          value: "report",
        ),
        const PopupMenuItem(
          child: Text("edit comment"),
          value: "share",
        ),
        const PopupMenuItem(
          child: Text("delete comment"),
          value: "delete",
        ),
      ],
    ).then<void>((_) {});
  }

  void showLikeBottomSheet(){
    showModalBottomSheet(
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
                  child: ListView.builder(itemBuilder: (context, index){
                    return Column(
                      children: [
                        sizedBox(hei: 5),
                        ListTile(
                          leading: ClipOval(child: UtilityHelper.image("https://scontent.fdel24-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=x3KaytIkZbUAX-EFm5V&_nc_ht=scontent.fdel24-1.fna&oh=00_AfDsQhK_sRxGXGQyQxugJqeDLXVNlMxMn3DldXmjVbzg9w&oe=653658E0")) ?? Container(height:50,width: 50, decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(100)),),
                          title: const Text("Liked!"),
                        ),
                        sizedBox(hei: 5),
                      ],
                    );
                  }, itemCount: likeCount,),
                ),
              ],
            ),
          ),
        )
    );
  }
}
