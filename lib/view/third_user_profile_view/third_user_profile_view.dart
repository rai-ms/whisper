import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/loading_tile.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/following_response_model.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/search_user/search_user_view_model.dart';

class ThirdUserProfileView extends StatefulWidget {
  const ThirdUserProfileView({super.key, required this.id});
  final String id;
  @override
  State<ThirdUserProfileView> createState() => _ThirdUserProfileViewState();
}

class _ThirdUserProfileViewState extends State<ThirdUserProfileView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchUserViewModel())
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(FontAwesomeIcons.arrowLeft),
          ),
        ),
        body: Center(
          child: Consumer<SearchUserViewModel>(builder: (context, pr1, ch) {
            return Column(
              children: [
                FutureBuilder(
                    future: pr1.getProfile(widget.id),
                    builder: (context, snapshot) {
                      if (pr1.apiResponseUserModel != null) {
                        return Column(
                          children: [
                            sizedBox(hei: 20),
                            Row(
                              children: [
                                sizedBox(wid: 5),
                                ClipOval(
                                  child: UtilityHelper.image(
                                    snapshot.data?.data[0].profilePic ?? dp,
                                    fit: BoxFit.fill, height: 70, width: 70)),
                                sizedBox(wid: 10),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(pr1.apiResponseUserModel!.data[0].fullName.toString()),
                                      Text(pr1.apiResponseUserModel!.data[0].username ?? ""),
                                    ],
                                  )),
                                snapshot.data?.data[0].isFollowing == true ? Expanded(
                                        flex: 2,
                                        child: AppRoundedButton(
                                          onTap: () {
                                            pr1.unfollowUser(widget.id);
                                          },
                                          title: AppStrings.unfollow,
                                          textStyle: AppStyle.primaryColorDarkMedium14(context),
                                        ),
                                      ) : Expanded(
                                    flex: 2,
                                    child: AppRoundedButton(
                                      height: 50,
                                      onTap: () async {
                                        pr1.followUser(widget.id);
                                      },
                                      title: AppStrings.follow,
                                      textStyle: AppStyle.primaryColorDarkMedium14(context),
                                    ),
                                  ),
                                sizedBox(wid: 20),
                              ],
                            ),
                            sizedBox(hei: 10),
                            Row(
                              children: [
                                sizedBox(wid: 5),
                                Text(pr1.apiResponseUserModel!.data[0].profileBio.toString()),
                              ],
                            ),
                            sizedBox(hei: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text("Following"),
                                    Text(pr1.apiResponseUserModel!.data[0].followingCount.toString()),
                                  ],
                                ),
                                sizedBox(wid: 10),
                                Column(
                                  children: [
                                    const Text("Follower"),
                                    Text(pr1.apiResponseUserModel!.data[0].followerCount.toString()),
                                  ],
                                ),
                                sizedBox(wid: 10),
                                Column(
                                  children: [
                                    const Text("Post"),
                                    Text(pr1.apiResponseUserModel!.data[0].postCount.toString()),
                                  ],
                                ),
                              ],
                            ),
                            sizedBox(hei: 10),
                            Row(
                              children: [
                                sizedBox(wid: 4),
                                Text("Post", style: AppStyle.primaryColorDarkMedium14(context),),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizedBox(wid: 4),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data?.data[0].postCount, itemBuilder: (context, index){
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.pushNamed(context, RouteName.postDetailsView, arguments: {"postId": snapshot.data?.data[0].userPosts[index].id ?? '', 'isLiked' : false});
                                                },
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: UtilityHelper.image(snapshot.data?.data[0].userPosts[index].url ?? dp)),
                                                    // Text(snapshot.data?.data[0].userPosts[index].caption.substring(0, 3) ?? "", style: AppStyle.whiteBold16,),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Align(alignment: Alignment.bottomCenter,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(FontAwesomeIcons.commentDots, size: 18,),
                                                              sizedBox(wid: 4),
                                                              Text(snapshot.data?.data[0].userPosts[index].commentCount.toString() ?? "", style: AppStyle.blackBold17,),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(FontAwesomeIcons.thumbsUp, size: 18,),
                                                              sizedBox(wid: 4),
                                                              Text(snapshot.data?.data[0].userPosts[index].likeCount.toString() ?? "", style: AppStyle.blackBold17),
                                                            ],
                                                          ),
                                                        ],
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (pr1.apiResponseUserModel == null) {
                        return Column(
                          children: [
                            sizedBox(hei: 20),
                            SizedBox(
                              height: 100,
                              child: Row(
                                children: [
                                  sizedBox(wid: 10),
                                  Expanded(
                                      flex: 3,
                                      child: ClipOval(
                                          child: Container(
                                        color: AppColors.grey,
                                      ))),
                                  sizedBox(wid: 20),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )),
                                  sizedBox(wid: 10),
                                ],
                              ),
                            ),
                            sizedBox(hei: 20),
                          ],
                        );
                      } else {
                        return const Text(AppStrings.noDataFound);
                      }
                    }),
                sizedBox(hei: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppStrings.followers, style: AppStyle.primaryColorDarkMedium14(context),
                    ),
                  ],
                ),
                sizedBox(hei: 10),
                Expanded(
                  flex: 2,
                  child: FutureBuilder(
                    future: pr1.getFollowers(id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Theme.of(context).primaryColorDark)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        child: ClipOval(
                                          child: UtilityHelper.image(pr1.response!.data!.followers![index].user.profilePic, height: 50, width: 50, fit: BoxFit.fill)),
                                      ),
                                      sizedBox(wid: 5),
                                      Text("${pr1.response!.data!.followers![index].user.username}", style: AppStyle.primaryColorDarkMedium16(context),),
                                      Text("${pr1.response!.data!.followers![index].user.email}", style: AppStyle.primaryColorDarkMedium14(context),),
                                      sizedBox(hei: 5),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: pr1.response!.data!.followers!.length ?? 0,
                        );
                      }
                      else if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return const LoadingWidgetTile();
                          },
                          itemCount: 10,
                        );
                      }
                      else if (snapshot.hasError) {
                        return const Center(
                          child: Text(AppStrings.errorOccured),
                        );
                      }
                      else {
                        return const Center(
                          child: Text(AppStrings.noDataFound),
                        );
                      }
                    },
                  ),
                ),
                sizedBox(hei: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    sizedBox(wid: 4),
                    Text("Following", style: AppStyle.primaryColorDarkMedium14(context),
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: FutureBuilder<GetFollowingApiRes?>(
                    future: pr1.getFollowing(id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Theme.of(context).primaryColorDark)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        child: ClipOval(
                                            child: UtilityHelper.image(pr1.followingApiRes!.data!.following![index].user.profilePic, height: 50, width: 50, fit: BoxFit.fill)),
                                      ),
                                      sizedBox(wid: 5),
                                      Text("${pr1.followingApiRes!.data!.following![index].user.username}", style: AppStyle.primaryColorDarkMedium16(context),),
                                      Text("${pr1.followingApiRes!.data!.following![index].user.email}", style: AppStyle.primaryColorDarkMedium14(context),),
                                      sizedBox(hei: 5),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: pr1.followingApiRes!.data!.following!.length ?? 0,
                        );
                      }
                      else if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                          itemCount: 10,
                        );
                      }
                      else if (snapshot.hasError) {
                        return const Center(
                          child: Text(AppStrings.errorOccured),
                        );
                      }
                      else {
                        return const Center(
                          child: Text(AppStrings.noDataFound),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: sizedBox())
              ],
            );
          }),
        ),
      ),
    );
  }
}
