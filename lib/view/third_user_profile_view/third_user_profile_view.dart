import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
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
            builder: (context, pr, ch) {
              return FutureBuilder(
                  future: pr.getProfile(widget.id),
                  builder: (context, snapshot) {
                    if(pr.apiResponseUserModel != null){
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 3, child: ClipOval(child: UtilityHelper.image(dp))),
                              Expanded(flex: 4,child: Text(snapshot.data!.data[0].username)),
                              snapshot.data!.data[0].isFollower == true? Expanded(flex: 3,child: AppRoundedButton(onTap: (){}, title: "Unfollow")) : Expanded(flex: 3,
                                child: AppRoundedButton(height: 50, onTap: () async {
                                  pr.followUser(widget.id);
                                }, title: "Follow"),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    else if(pr.apiResponseUserModel == null){
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
              );
            }
        ),),
      ),
    );
  }
}
