import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';
import 'package:whisper/view_model/settings_view_model/settings_view_model.dart';

import '../home_view/widgets/HomePageAppBar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppGlobalProvider()),
      ChangeNotifierProvider(create: (context) => AppBarViewModel()),
      ChangeNotifierProvider(create: (context) => SettingsViewModel()),
    ],
    child: const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Settings"),
            HomePageAppBar(),
          ],
        ),),
    ),);
  }
}
