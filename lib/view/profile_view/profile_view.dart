import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/utils/utils.dart';
import 'package:whisper/view/profile_view/widgets/posts_follower_following.dart';
import 'package:whisper/view/profile_view/widgets/profile_top_view.dart';
import 'package:whisper/view_model/personal_profile_view_model/personal_profile_view_model.dart';
import '../../model/my_profile_api_response.dart';
import '../../view_model/global_provider/get_profile_data_provider.dart';
import '../../view_model/personal_profile_view_model/api_res_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    loadLocal();
  }

  loadLocal() async {
    dp = await UserData.getProfilePic();
    debugPrint("Dp is $dp");
    // await GetProfileData.getJoinedDate();
    // await GetProfileData.getBio();
    await GetProfileData().getFullName();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PersonalProfileViewModel()),
        ChangeNotifierProvider(create: (context) => GetProfileData()),
        ChangeNotifierProvider(create: (context) => PostViewApiResponseProvider()),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          key: const PageStorageKey<String>('personalProfileViewPath'),
          child: Column(
            children: [
              Consumer<GetProfileData>(builder: (context, provider, child) {
                return FutureBuilder(
                    future: provider.loadAllDataWithProfilePic(),
                    builder: (context, data) {
                      String? username = data.data;
                      if (data.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            const ProfileTopView(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  height: 60,
                                  color: AppColors.grey,
                                )
                              ],
                            ),
                          ],
                        );
                      } else if (data.hasError) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Unable to load!",
                              style: AppStyle.blackBold24,
                            ),
                          ],
                        );
                      } else if (data.hasData) {
                        return Column(
                          children: [
                            const ProfileTopView(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "$username",
                                  style:
                                      AppStyle.primaryColorDarkMedium(context),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Ashish Rai",
                              style: AppStyle.primaryColorDarkMedium(context),
                            ),
                          ],
                        );
                      }
                    });
              }),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            sizedBox(wid: 15),
                            FutureBuilder(
                              future: UserData.getFullName(),
                              builder: (context, snap) {
                                return Text(
                                  snap.data ?? "Ashish",
                                  style: AppStyle.whiteBold16,
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizedBox(wid: 10),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                                  context, RouteName.editProfileView)
                              .whenComplete(() {
                            setState(() {});
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Row(
                            children: [
                              sizedBox(wid: 5),
                              const Icon(Icons.edit, color: AppColors.white),
                              Text(
                                AppStrings.editProfile,
                                style: AppStyle.whiteBold16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBox(wid: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.more_horiz,
                            color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox(hei: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppStrings.details,
                    style: AppStyle.primaryColorDarkMedium25(context),
                  ),
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
                          const Icon(
                            FontAwesomeIcons.house,
                            color: AppColors.grey,
                          ),
                          sizedBox(wid: 10),
                          Consumer<GetProfileData>(builder: (context, pr, ch) {
                            return FutureBuilder(
                              future: pr.getBio(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return Text(
                                    snap.data.toString() ?? "",
                                    style: AppStyle.primaryColorDarkMedium(
                                        context),
                                  );
                                } else {
                                  return const Text(AppStrings.emptyString);
                                }
                              },
                            );
                          }),
                        ],
                      ),
                      sizedBox(hei: 10),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            color: AppColors.grey,
                          ),
                          sizedBox(wid: 10),
                          Consumer<GetProfileData>(
                              builder: (context, provider, child) {
                            return FutureBuilder<String?>(
                                future: provider.getJoinedDate(),
                                builder: (context, data) {
                                  if (!data.hasData ||
                                      data.connectionState ==
                                          ConnectionState.waiting) {
                                    return Container(
                                      height: 50,
                                      width: 100,
                                      color: AppColors.grey,
                                    );
                                  } else if (data.hasData) {
                                    String? joinDate = data.data;
                                    return Text(
                                      "${AppStrings.joinedOn}${Utils.formatDateTime(joinDate!)}",
                                      style: AppStyle.primaryColorDarkMedium(
                                          context),
                                    );
                                  }
                                  return Text("${data.data}");
                                });
                          }),
                        ],
                      ),
                      sizedBox(hei: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.grey,
                          ),
                          sizedBox(wid: 10),
                          Text(
                            AppStrings.seeYourAbout,
                            style: AppStyle.primaryColorDarkMedium(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              sizedBox(hei: 10),
              Divider(
                thickness: 20,
                color: Theme.of(context).dividerColor,
              ),
              sizedBox(hei: 10),
              Consumer<PersonalProfileViewModel>(builder: (context, pr, ch) {
                return FutureBuilder<ApiResponseMyProfileUserDataModel?>(
                    future: ProfileRepository.getMyProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // debugPrint("***************Data Received******************");
                        debugPrint(snapshot.data!.data[0].userPosts.length.toString());
                        return PostFollowerFollowing( res: snapshot.data!,);
                      } else {
                        return sizedBox();
                      }
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
