import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: getFullWidth(context),
      decoration: const BoxDecoration(
        color: AppColors.blueSplashScreen
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sizedBox(hei: 60),
          Consumer<AppBarViewModel>(
            builder: (context, provider, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                [
                  sizedBox(wid: 20),
                  InkWell(
                    onTap: (){
                      provider.logoutUser(context);
                    },
                    child: const Icon(Icons.exit_to_app, color: AppColors.white,)),
                  sizedBox(wid: 30),
                  Text("AppBar", style: AppStyle.whiteBold20,),
                ],
              );
            }
          ),
          sizedBox(hei: 10),
        ],
      ),
    );
  }
}
