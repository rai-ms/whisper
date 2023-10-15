import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/view/home_view/widgets/HomePageAppBar.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';
import 'package:whisper/view_model/home_view_view_model/app_bar_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppBarViewModel()),
      ],
      child:  const Scaffold(
        body: Center(
          child: Column(
            children: [
              HomePageAppBar(),
              Text(
                  "Center of HomeView"
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
            child: AppBottomNavigationBar()),
      ),
    );
  }
}
