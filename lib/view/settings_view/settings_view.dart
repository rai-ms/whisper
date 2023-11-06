import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/settings_view_model/settings_view_model.dart';

import '../home_view/widgets/settings_view_logout.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppGlobalProvider()),
        ChangeNotifierProvider(create: (context) => AppBarViewModel()),
        ChangeNotifierProvider(create: (context) => SettingsViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Platform.isAndroid
                ? Icons.arrow_back
                : Icons.arrow_back_ios_new),
          ),
        ),
        body: Center(
          child: Consumer<SettingsViewModel>(
            builder: (context, pr, ch) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Settings", style: AppStyle.primaryColorDarkMedium25(context),),
                  InkWell(
                    onTap: (){
                      pr.logoutUser(context);
                    },
                    child: const LogoutViewSettings()),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
