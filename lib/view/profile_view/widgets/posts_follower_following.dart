import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/view/profile_view/widgets/following_list.dart';
import 'package:whisper/view/profile_view/widgets/post_list.dart';
import 'package:whisper/view_model/personal_profile_view_model/personal_profile_view_model.dart';
import '../../../global/global.dart';
import '../../../model/my_profile_api_response.dart';
import '../../../model/user_profile_response.dart';
import '../../../utils/app_helper/app_style.dart';
import '../../../view_model/personal_profile_view_model/api_res_provider.dart';
import 'my_followers_list.dart';

class PostFollowerFollowing extends StatefulWidget {
  const PostFollowerFollowing({super.key, required this.res});

  final ApiResponseMyProfileUserDataModel res;

  @override
  State<PostFollowerFollowing> createState() => _PostFollowerFollowingState();
}

class _PostFollowerFollowingState extends State<PostFollowerFollowing> {
  ApiResponseUserDataModel? response;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer2<PersonalProfileViewModel, PostViewApiResponseProvider>(
            builder: (context, provider, provider2, child) {
          return Column(
            children: [
              Row(
                children: [
                  sizedBox(wid: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        provider.index = 0;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: provider.index == 0
                                ? Theme.of(context).dividerColor
                                : null,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Posts ${widget.res.data[0].postCount}",
                          style: AppStyle.primaryColorDarkMedium20(context),
                        )),
                      ),
                    ),
                  ),
                  sizedBox(wid: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        provider.index = 1;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: provider.index == 1
                                ? Theme.of(context).dividerColor
                                : null,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Follower ${widget.res.data[0].followerCount}",
                          style: AppStyle.primaryColorDarkMedium20(context),
                        )),
                      ),
                    ),
                  ),
                  sizedBox(wid: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        provider.index = 2;
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: provider.index == 2 ? Theme.of(context).dividerColor : null,
                          borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text("Following ${widget.res.data[0].followingCount}",
                          style: AppStyle.primaryColorDarkMedium20(context),
                        )),
                      ),
                    ),
                  ),
                  sizedBox(wid: 6),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // if(provider2.res != null) PostList(postList: provider2.res!.data[0].userPosts,),
              if (provider.index == 0)
                SizedBox(
                    height: 500,
                    width: getFullWidth(
                        context), // Make sure this height is within the parent's constraints.
                    child: PostList(
                      postList: widget.res.data[0].userPosts,
                    )),
              // response = snapshot.data;
              // provider2.res = snapshot.data;
              // debugPrint(response!.data![0].userPosts.length.toString());

              //   FutureBuilder<ApiResponseUserDataModel?>(
              //   key: const PageStorageKey<String>(StoragePathKey.postListPathFuture) ,
              //   future: provider2.getProfile(),
              //   builder: (context,AsyncSnapshot<ApiResponseUserDataModel?> snapshot) {
              //     if(snapshot.connectionState == ConnectionState.waiting){
              //       return Container(
              //         height: 500,
              //         width: getFullWidth(context),
              //         color: AppColors.grey,
              //       );
              //       // return const Center(child: CircularProgressIndicator());
              //     }
              //     // else if(snapshot.hasError){
              //     //   debugPrint("${snapshot.error} is the error");
              //     //   return const Center(child: Text(AppStrings.errorOccured),);
              //     // }
              //     else if(snapshot.hasData){
              //       // response = snapshot.data;
              //       // provider2.res = snapshot.data;
              //       // debugPrint(response!.data![0].userPosts.length.toString());
              //       return SizedBox(
              //         height: 500,
              //         width: getFullWidth(context),// Make sure this height is within the parent's constraints.
              //         child: PostList(postList: widget.res.data[0].userPosts,)
              //
              //       );
              //     }
              //     else {
              //       return const Center(child: Text(AppStrings.errorOccured),);
              //     }
              //   }
              // ),
              if (provider.index == 1) const Followers(),
              if (provider.index == 2) const Following(),
            ],
          );
        }),
      ],
    );
  }
}
