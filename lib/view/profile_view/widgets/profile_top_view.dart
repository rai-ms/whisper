import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';

import '../../../utils/app_helper/app_color.dart';

class ProfileTopView extends StatelessWidget {
  const ProfileTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: getFullWidth(context),
              height: getFullHeight(context) * .255,
              child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t1.6435-9/184701903_2953147051628508_9163443761182680284_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=300f58&_nc_ohc=NvdnVSdGmdQAX8cpxFQ&_nc_ht=scontent.fdel72-1.fna&oh=00_AfCBxF27sYwjpgwzHa0dXrXH2PyTWuupASxs11p41PPV4A&oe=65570AD2", fit: BoxFit.fitWidth)
              ,
            ),
            Padding(
              padding: EdgeInsets.only(top: getFullHeight(context) * .12, left: 10),
              child: Container(
                width: getFullWidth(context) * .45,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white, width: 5),
                  borderRadius: BorderRadius.circular(1000)
                ),
                child: Stack(
                  children: [
                    ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=XnnVIAFitkUAX_luQ-r&_nc_ht=scontent.fdel72-1.fna&oh=00_AfBOBvAf8MrWfdpbU1NSzWArdT4TUuEa7jMdk6awI1ZGhw&oe=65345EA0")),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.white, width: 5),
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
