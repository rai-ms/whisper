import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import 'package:whisper/utils/routes/navigate_route.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/home_view_view_model/post_card_comment_view_model.dart';
import 'package:whisper/view_model/home_view_view_model/share_post_view_model.dart';
import 'package:whisper/view_model/personal_profile_view_model/get_profile_data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserData().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppGlobalProvider()),
        ChangeNotifierProvider(create: (context)=> PostCardCommentViewModel()),
        ChangeNotifierProvider(create: (context)=> PostShareViewModel()),
        ChangeNotifierProvider(create: (context)=> GetProfileData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.lightBlack,
          primaryColorLight: AppColors.lightBlack,
          primaryColorDark: AppColors.white,
          cardColor: AppColors.lightBlack,
          canvasColor: AppColors.grey,
          dividerColor: Colors.grey.shade800,
          appBarTheme: const AppBarTheme(
            color: AppColors.lightBlack,
            centerTitle: true
          ),
        ),
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor:  AppColors.blueSplashScreen,
          cardColor: Colors.grey.shade50,
          dividerColor: Colors.grey.shade300,
          canvasColor: Colors.grey,
          primaryColorDark: AppColors.black,
          primaryColorLight: Colors.white,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: AppStyle.whiteMedium22,
            backgroundColor: AppColors.blueSplashScreen,
            shadowColor: AppColors.grey,
            foregroundColor: AppColors.white
          ),
        ),
        themeMode: ThemeMode.system,
        onGenerateRoute: NavigateRoute.onGenerate,
        initialRoute: RouteName.splashscreen,
    ),);
  }
}