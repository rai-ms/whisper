import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view/profile_view/widgets/posts_photos_friends.dart';
import 'package:whisper/view/profile_view/widgets/profile_top_view.dart';
import 'package:whisper/view_model/personal_profile_view_model/personal_profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PersonalProfileViewModel()),
    ] ,child: SingleChildScrollView(
      key: const PageStorageKey<String>('personalProfileViewPath'),
      child: Column(
        children:
        [
          const ProfileTopView(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10,),
              Text("Ashish Rai", style: AppStyle.blackBold24,),
            ],
          ),
          const SizedBox(height: 5,),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex:4,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.blueSplashScreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              sizedBox(wid: 5),
                              const Icon(Icons.add, color: AppColors.white),
                              Text("Add To Story", style: AppStyle.whiteBold16,),
                            ],
                          ),
                        ),),
                      sizedBox(wid: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              sizedBox(wid: 5),
                              const Icon(Icons.edit, color: AppColors.white),
                              Text("Edit Profile", style: AppStyle.whiteBold16,),
                            ],
                          ),
                        ),),
                      sizedBox(wid: 10),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.more_horiz, color: AppColors.white),
                        ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          sizedBox(hei: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10,),
              Text("Details", style: AppStyle.blackBold24,),
            ],
          ),
          sizedBox(hei: 10),
          Row(
            children: [
              sizedBox(wid: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.house, color: AppColors.grey,),
                      sizedBox(wid: 10),
                      Text("Lives in Ballia", style: AppStyle.blackMedium16,),
                    ],
                  ),
                  sizedBox(hei: 10),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.clock, color: AppColors.grey,),
                      sizedBox(wid: 10),
                      Text("Joined on July 2023", style: AppStyle.blackMedium16,),
                    ],
                  ),
                  sizedBox(hei: 10),
                  Row(
                    children: [
                      const Icon(Icons.more_horiz, color: AppColors.grey,),
                      sizedBox(wid: 10),
                      Text("See your About Info", style: AppStyle.blackMedium16,),
                    ],
                  ),
                ],
              ),
            ],
          ),
          sizedBox(hei: 10),
          Container(
            width: getFullWidth(context),
            height: 20,
            color: AppColors.grey,
          ),
          sizedBox(hei: 10),
          const PostPhotosFriends(),

        ],
      ),
    ),);
  }
}
