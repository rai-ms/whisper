import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/settings_view_model/settings_view_model.dart';

class LogoutViewSettings extends StatefulWidget {
  const LogoutViewSettings({super.key});

  @override
  State<LogoutViewSettings> createState() => _LogoutViewSettingsState();
}

class _LogoutViewSettingsState extends State<LogoutViewSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
              Text("Logout", style: AppStyle.primaryColorDarkMedium20(context),)
            ],
          );
        }),
        sizedBox(hei: 10),
      ],
    );
  }
}
