import 'package:flutter/material.dart';
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

class _FollowersState extends State<Followers> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context)
  {
    super.build(context);
    return SizedBox(
      height: 500,
      child: FutureBuilder<GetFollowerApiRes?>(
        future: PostViewApiResponseProvider.getFollowers(),
        builder: (context, snapshot) {
          if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
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
          else if(snapshot.data == null){
            return const Text("No Data");
          }
          else {
            GetFollowerApiRes getFollowerApiRes = snapshot.data!;
            return ListView.builder(
              key: const PageStorageKey<String>(StoragePathKey.friendsListPath),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.thirdUserProfileView, arguments: {"id" : getFollowerApiRes.data!.followers![index].user.id});
                  },
                  title: Text("${getFollowerApiRes.data!.followers![index].user.username}"),
                  subtitle: Text("${getFollowerApiRes.data!.followers![index].user.email}"),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: UtilityHelper.image(dp)),
                );
              },
              itemCount: getFollowerApiRes.data!.followers!.length,);
          }
        }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
