import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/view_model/search_user/search_user_view_model.dart';

import '../../view_model/personal_profile_view_model/api_res_provider.dart';

class ThirdUserProfileView extends StatefulWidget {
  const ThirdUserProfileView({super.key, required this.id});
  final String id;
  @override
  State<ThirdUserProfileView> createState() => _ThirdUserProfileViewState();
}

class _ThirdUserProfileViewState extends State<ThirdUserProfileView> {

  @override
  Widget build(BuildContext context) {
    // debugPrint("=======================id is ${widget.id} ========================");
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => SearchUserViewModel())],
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(onTap: (){
            // Navigator.pushNamedAndRemoveUntil(context, RouteName.homeView, (route)=> false);
            Navigator.pop(context);
          },child: const Icon(FontAwesomeIcons.arrowLeft),),
        ),
        body: Center(child: Consumer<SearchUserViewModel>(
            builder: (context, pr1, ch) {
              return Column(
                children: [
                  FutureBuilder(
                      future: pr1.getProfile(widget.id),
                      builder: (context, snapshot) {
                        if(pr1.apiResponseUserModel != null){
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(flex: 3, child: ClipOval(child: UtilityHelper.image(dp))),
                                  Expanded(flex: 4,child: Text(snapshot.data?.data[0].username ?? "")),
                                  snapshot.data?.data[0].isFollowing == true?
                                  Expanded(
                                    flex: 3,
                                    child: AppRoundedButton(
                                      onTap: (){
                                        pr1.unfollowUser(widget.id);
                                      },
                                    title: "Unfollow",
                                    ),
                                  )
                                    :
                                  Expanded(
                                    flex: 3,
                                    child: AppRoundedButton(height: 50, onTap: () async {
                                      pr1.followUser(widget.id);
                                    }, title: "Follow"),
                                  ),
                                  sizedBox(wid: 20),
                                ],
                              ),
                            ],
                          );
                        }
                        else if(pr1.apiResponseUserModel == null){
                          return Column(
                            children: [
                              sizedBox(hei: 20),
                              SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    sizedBox(wid: 10),
                                    Expanded(flex: 3, child: ClipOval(child: Container(color: AppColors.grey,))),
                                    sizedBox(wid: 20),
                                    Expanded(flex: 4,child: Container(decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(20)
                                    ),)),
                                    sizedBox(wid: 10),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return const Text("No Data Found!");
                        }

                      }
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: pr1.getFollowers(id: widget.id),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemBuilder: (context, index){
                              return Container(
                                height: 100,
                                width: 350,
                                decoration: const BoxDecoration(
                                  color: AppColors.grey
                                ),
                                child: Text("${snapshot.data!.data!.followers![index].user.username}"
                                  ),
                              );
                          }, itemCount: snapshot.data!.data!.followers!.length,);
                        }
                        else if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                          return ListView.builder(itemBuilder: (context, index){
                            return Container(
                              height: 100,
                              width: 350,
                              decoration: const BoxDecoration(
                                color: AppColors.grey
                              ),
                            );
                          }, itemCount: 10,);
                        }
                        else if(snapshot.hasError){
                          return const Center(child: Text(AppStrings.errorOccured),);
                        }
                        else {
                          return const Center(child: Text(AppStrings.noDataFound),);
                        }
                      },),
                  )
                ],
              );
            }
        ),),
      ),
    );
  }
}
