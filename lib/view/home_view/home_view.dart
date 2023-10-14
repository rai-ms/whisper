import 'package:flutter/material.dart';
import 'package:whisper/view/home_view/widgets/HomePageAppBar.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          children: [
            HomePageAppBar(),
            Text(
            "Center of HomeView"
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: AppBottomNavigationBar()),
    );
  }
}
