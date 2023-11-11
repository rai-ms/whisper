import 'package:flutter/material.dart';
import 'package:whisper/components/app_dialog.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../../utils/app_helper/app_color.dart';

class ProfileTopView extends StatelessWidget {
  const ProfileTopView({super.key, this.profilePic});
  final String? profilePic;

  @override
  Widget build(BuildContext context) {
    Widget dpImage = UtilityHelper.image(profilePic ?? dp, fit: BoxFit.fill);
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: getFullWidth(context),
              height: getFullHeight(context) * .255,
              child: UtilityHelper.image(
                  "https://images.unsplash.com/photo-1610252305328-a87676353dc7?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDB8fG5hdHVyYWwlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww&w=800",
                  fit: BoxFit.fitWidth),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getFullHeight(context) * .1 + getFullHeight(context) * .05,
              ),
              child: Container(
                height: getFullWidth(context) * .3,
                width: getFullWidth(context) * .3,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColorDark, width: 5),
                    borderRadius: BorderRadius.circular(1000)),
                child: Stack(
                  children: [
                    SizedBox(
                      height: getFullWidth(context) * .3,
                      width: getFullWidth(context) * .3,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: AppDialog(
                                    dialogWidget: Padding(
                                      padding: const EdgeInsets.all(1.2),
                                      child: UtilityHelper.image(
                                          profilePic ?? dp,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: FutureBuilder(
                          future: UserData.getProfilePic(),
                          builder: (context, snap) {
                            return ClipOval(
                              child: UtilityHelper.image(snap.data ?? dp, fit: BoxFit.fill),
                            );
                          }
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: Theme.of(context).primaryColorDark,
                                width: 5),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                            color: AppColors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
