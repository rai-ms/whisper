import 'package:flutter/material.dart';
import 'package:whisper/view/home_view/widgets/bottom_navigation.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(
        "Center of HomeView"
      ),),
      bottomNavigationBar: SafeArea(child: AppBottomNavigationBar()),
    );
  }
}
