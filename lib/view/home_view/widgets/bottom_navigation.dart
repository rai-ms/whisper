import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper/utils/app_helper/app_color.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueSplashScreen
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.white,),
          Icon(Icons.home_outlined, color: AppColors.white,),
          Icon(Icons.mark_unread_chat_alt_outlined, color: AppColors.white,),
          Icon(Icons.settings, color: AppColors.white,),
        ],
      ),
    );
  }
}
