import 'package:flutter/material.dart';
import 'package:whisper/components/app_dialog.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import '../../../utils/app_helper/app_color.dart';

class ProfileTopView extends StatelessWidget {
  const ProfileTopView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget dp = UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=XnnVIAFitkUAX_luQ-r&_nc_ht=scontent.fdel72-1.fna&oh=00_AfBOBvAf8MrWfdpbU1NSzWArdT4TUuEa7jMdk6awI1ZGhw&oe=65345EA0",);
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: getFullWidth(context),
              height: getFullHeight(context) * .255,
              child: UtilityHelper.image("https://images.unsplash.com/photo-1610252305328-a87676353dc7?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDB8fG5hdHVyYWwlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww&w=800", fit: BoxFit.fitWidth)
              ,
            ),
            Padding(
              padding: EdgeInsets.only(top: getFullHeight(context) * .12, left: 10),
              child: Container(
                width: getFullWidth(context) * .45,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColorDark, width: 5),
                  borderRadius: BorderRadius.circular(1000)
                ),
                child: Stack(
                  children: [
                    InkWell(onTap:(){
                      showDialog(context: context, builder: (context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: AppDialog(
                              dialogWidget:dp,
                          ),
                        );
                      });
                    },child: ClipOval(child: dp)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Theme.of(context).primaryColorDark, width: 5),
                        ),
                        child: const Icon(Icons.camera_alt_outlined, size: 30,color: AppColors.black,)),
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
