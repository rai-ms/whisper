import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/view/profile_view/widgets/photos_list.dart';
import 'package:whisper/view/profile_view/widgets/post_list.dart';
import 'package:whisper/view_model/personal_profile_view_model/personal_profile_view_model.dart';
import '../../../global/global.dart';
import '../../../model/user_profile_response.dart';
import '../../../utils/app_helper/app_keys.dart';
import '../../../utils/app_helper/app_style.dart';
import '../../../view_model/global_provider/global_provider.dart';
import '../../../view_model/personal_profile_view_model/api_res_provider.dart';
import 'friends_list.dart';

class PostFollowerFollowing extends StatefulWidget {
  const PostFollowerFollowing({super.key});

  @override
  State<PostFollowerFollowing> createState() => _PostFollowerFollowingState();
}

class _PostFollowerFollowingState extends State<PostFollowerFollowing> {
  UserProfileDataResponse? response;
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
                        onTap:(){
                          provider.index = 0;
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: provider.index == 0? Theme.of(context).dividerColor : null,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Posts", style: AppStyle.primaryColorDarkMedium20(context),)),
                        ),
                      ),
                    ),
                    sizedBox(wid: 6),
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          provider.index = 1;
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: provider.index == 1? Theme.of(context).dividerColor  : null,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Follower", style: AppStyle.primaryColorDarkMedium20(context),)),
                        ),
                      ),
                    ),
                    sizedBox(wid: 6),
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          provider.index = 2;
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: provider.index == 2? Theme.of(context).dividerColor  : null,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Following", style: AppStyle.primaryColorDarkMedium20(context),)),
                        ),
                      ),
                    ),
                    sizedBox(wid: 6),
                  ],
                ),
                const SizedBox(height: 10,),
                FutureBuilder<UserProfileDataResponse?>(
                  key: const PageStorageKey<String>(StoragePathKey.postListPathFuture) ,
                  future: provider2.getProfile(),
                  builder: (context,AsyncSnapshot<UserProfileDataResponse?> snapshot) {
                    if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        height: 500,
                        width: getFullWidth(context),
                        color: AppColors.grey,
                      );
                    }
                    else if(snapshot.hasError){
                      return const Center(child: Text(AppStrings.errorOccured),);
                    }
                    else if(snapshot.hasData){
                      response = snapshot.data;
                      debugPrint(response!.userProfiles[0].userPosts.length.toString());
                      return SizedBox(
                        height: 500,
                        width: getFullWidth(context),// Make sure this height is within the parent's constraints.
                        child: provider.index == 0?  PostList(postList: response!.userProfiles[0].userPosts,) : provider.index == 1 ? const FriendsList() : const PhotosList(),
                      );
                    }
                    else {
                      return const Center(child: Text(AppStrings.errorOccured),);
                    }
                  }
                )
              ],
            );
          }
        ),
      ],
    );
  }


}
