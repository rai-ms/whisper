import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/routes/navigate_route.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/home_view_view_model/post_card_comment_view_model.dart';
import 'package:whisper/view_model/home_view_view_model/share_post_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppGlobalProvider()),
        ChangeNotifierProvider(create: (context)=> PostCardCommentViewModel()),
        ChangeNotifierProvider(create: (context)=> PostShareViewModel()),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: NavigateRoute.onGenerate,
      initialRoute: RouteName.splashscreen,
    ),);
  }
}
