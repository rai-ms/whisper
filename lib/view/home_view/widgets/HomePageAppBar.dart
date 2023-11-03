import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/settings_view_model/settings_view_model.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        sizedBox(hei: 60),
        Consumer<SettingsViewModel>(builder: (context, provider, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedBox(wid: 20),
              InkWell(
                  onTap: () {
                    provider.logoutUser(context);
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  )),
              sizedBox(wid: 30),
              const Text("Logout")
            ],
          );
        }),
        sizedBox(hei: 10),
      ],
    );
  }
}
