import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/view_model/personal_profile_view_model/api_res_provider.dart';
import '../../../components/utility_helper.dart';
import '../../../model/following_response_model.dart';
import '../../../utils/app_helper/app_color.dart';
import '../../../utils/app_helper/app_keys.dart';
import '../../../utils/routes/route_name.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Column(
        children: [
          SizedBox(
            height: getFullHeight(context) / 2,
            child: Consumer<PostViewApiResponseProvider>(
                builder: (context, pr, ch) {
              return FutureBuilder<GetFollowingApiRes?>(
                  future: pr.getFollowing(),
                  builder: (context, snapshot) {
                    if (pr.getFollowingApiRes == null) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.grey,
                              radius: 20,
                            ),
                          );
                        },
                        itemCount: 5,
                      );
                    }
                    // else if(snapshot.data == null){
                    //   return const Text("No Data");
                    // }
                    else {
                      GetFollowingApiRes getFollowingApiRes =
                          pr.getFollowingApiRes!;
                      return ListView.builder(
                        key: const PageStorageKey<String>(
                            StoragePathKey.friendsListPath),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.thirdUserProfileView, arguments: { "id": getFollowingApiRes.data!.following![index].user.id});
                            },
                            title: Text("${getFollowingApiRes.data!.following![index].user.username}"),
                            subtitle: Text("${getFollowingApiRes.data!.following![index].user.email}"),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: UtilityHelper.image(getFollowingApiRes.data!.following![index].user.profilePic ??dp, width: 50)),
                          );
                        },
                        itemCount: getFollowingApiRes.data!.following!.length,
                      );
                    }
                  });
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
