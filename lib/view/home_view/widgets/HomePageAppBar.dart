import 'package:flutter/cupertino.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getFullWidth(context),
      height: 100,
      decoration: const BoxDecoration(
        color: AppColors.blueSplashScreen
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AppBar", style: AppStyle.whiteBold20,),

        ],
      ),
    );
  }
}
