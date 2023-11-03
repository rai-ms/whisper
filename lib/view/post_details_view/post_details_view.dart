import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/view_model/post_details_provider/post_details_provider.dart';
import '../../components/app_dialog.dart';
import '../../utils/app_helper/app_style.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView(
      {super.key, required this.postId, required this.isLiked});

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
                                SizedBox(
                                  height: 470,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          sizedBox(wid: 10),
                                          if (pr.apiResponseUserDataModel == null) const CircleAvatar(radius: 40,),
                                          if (pr.apiResponseUserDataModel != null) SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: ClipOval(
                                                child: UtilityHelper.image( pr.apiResponseUserDataModel?.data[0].profilePic, fit: BoxFit.fill),
                                              ),
                                            ),
                                          sizedBox(wid: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              if (pr.apiResponsePostModel == null) const Text("Loading..."),
                                              if (pr.apiResponsePostModel != null) Text(pr.apiResponseUserDataModel!.data[0].username.toString() ?? "Loading..."),
                                              if (pr.apiResponsePostModel == null) const Text("Loading..."),
                                              if (pr.apiResponsePostModel != null) Text(pr.apiResponsePostModel!.data[0].createdAt.toString() ?? "Loading..."),
                                            ],
                                          ),
                                          Expanded(child: sizedBox()),
                                          if(pr.apiResponseUserDataModel != null) FutureBuilder(
                                            future: pr.getUserName(),
                                            builder: (context, snap) {
                                              if(snap.hasData && snap.data == pr.apiResponseUserDataModel!.data[0].username){
                                                return IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                                                              child: AppDialog( dialogWidget: Padding(
                                                                padding: const EdgeInsets.all(1.2),
                                                                child: Column(
                                                                  children: [
                                                                    TextFormField(),
                                                                    AppRoundedButton(onTap: (){
                                                                      pr.editPostCaption();
                                                                    }, title: AppStrings.save),
                                                                  ],
                                                                ),
                                                              ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    icon: const Icon(Icons.edit));
                                              }
                                              else {
                                                return sizedBox();
                                              }
                                            }
                                          ),
                                          sizedBox(wid: 10),
                                        ],
                                      ),
                                      sizedBox(hei: 10),
                                      if (pr.apiResponseUserDataModel == null) Container(
                                          height: 280,
                                          width: getFullWidth(context),
                                          color: AppColors.grey,
                                        ),
                                      if (pr.apiResponseUserDataModel != null) SizedBox(
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
                                              ]),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    pr.likePost();
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(!PostDetailsProvider.isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                        color: Theme.of(context).primaryColorDark,
                                                      ),
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
                                ),
                                if(pr.res != null) Column(
                                  children: [
                                      ...List.generate(
                                        pr.res!.data!.comments!.length,
                                        (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: ClipOval(
                                                    child: UtilityHelper.image(pr.res!.data!.comments?[index].user.profilePic ?? dp, height: 40, width: 40),
                                                  )),
                                                sizedBox(wid: 5),
                                                Expanded(
                                                  flex: 90,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: const BoxConstraints(
                                                                minHeight: 60),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            sizedBox(wid: 5),
                                                            Expanded(
                                                              flex: 90,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Text(pr
                                                                        .res!
                                                                        .data!
                                                                        .comments![
                                                                            index]
                                                                        .user
                                                                        .username),
                                                                  ),
                                                                  Container(
                                                                    constraints:const BoxConstraints(maxWidth: 450,minWidth:300, minHeight: 40,),
                                                                    padding: const EdgeInsets.only(
                                                                        left:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(10),
                                                                    ),
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            pr.res!.data!.comments![index].comment,
                                                                            style:
                                                                                AppStyle.blackMedium16,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  sizedBox(
                                                                      hei: 4),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(pr .res! .data!.comments![index].user.email),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: PopupMenuButton(
                                                    icon: const Icon(
                                                        Icons.more_vert),
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        // if(pr.res!.data!.comments?[index].user.username == username) PopupMenuItem(
                                                        //   value: "edit",
                                                        //   child: const Text("Edit comment"),
                                                        //   onTap: (){
                                                        //     // pr.editMyComment(context: context, editOn: widget.comments![index].comment,commentID:  widget.comments![index].id);
                                                        //   },
                                                        // ),
                                                        if (pr.res!.data!.comments?[index].user.id == PostDetailsProvider.userId) PopupMenuItem(
                                                            value: "delete",
                                                            child: const Text( "Delete comment"),
                                                            onTap: () {
                                                              pr.deleteMyComment( commentId: pr.res!.data!.comments?[index].id.toString() ?? "", context: context);
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
                                if (pr.res == null) Container()
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
                                  pr.sendComment();
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
}
