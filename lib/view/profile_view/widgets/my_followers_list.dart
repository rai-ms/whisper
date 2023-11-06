import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/follower_response.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import '../../../utils/app_helper/app_keys.dart';
import '../../../utils/routes/route_name.dart';
import '../../../view_model/personal_profile_view_model/api_res_provider.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});
  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SizedBox(
        height: 500,
        child: Consumer<PostViewApiResponseProvider>(builder: (context, pr, ch) {
          return FutureBuilder<GetFollowerApiRes?>(
              future: pr.getFollowers(),
              builder: (context, snapshot) {
                if (pr.response == null) {
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
                else {
                  GetFollowerApiRes? getFollowerApiRes = pr.response;
                  return ListView.builder(
                    key: const PageStorageKey<String>(
                        StoragePathKey.friendsListPath),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 80,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.thirdUserProfileView, arguments: {"id": getFollowerApiRes.data!.followers![index].user.id});
                          },
                          title: Text("${getFollowerApiRes!.data!.followers![index].user.username}"),
                          subtitle: Text("${getFollowerApiRes!.data!.followers![index].user.email}"),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: UtilityHelper.image(getFollowerApiRes.data!.followers![index].user.profilePic ?? dp, width: 50)),
                        ),
                      );
                    },
                    itemCount: getFollowerApiRes!.data!.followers!.length,
                  );
                }
              });
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
