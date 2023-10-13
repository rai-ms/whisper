import 'package:flutter/material.dart';
import 'package:whisper/utils/app_helper/app_color.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  double? index = 2;
  double? selectedSize = 40;
  double? unSelectedSize = 30;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blueSplashScreen,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [
              InkWell(
                onTap: (){
                  if(index != 0){
                    index = 0;
                    setState(() {

                    });
                  }
                },
                child: Icon(Icons.search, color: AppColors.white,size: index == 0? selectedSize : unSelectedSize,)),
              InkWell(
                  onTap: (){
                    if(index != 1){
                      index = 1;
                      setState(() {

                      });
                    }
                  },
                  child: Icon(Icons.home_outlined, color: AppColors.white,size: index == 1? selectedSize : unSelectedSize,)),
              InkWell(
                  onTap: (){
                    if(index != 2){
                      index = 2;
                      setState(() {

                      });
                    }
                  },
                  child: Icon(Icons.mark_unread_chat_alt_outlined, color: AppColors.white,size: index == 2? selectedSize : unSelectedSize,)),
              InkWell(
                  onTap: (){
                    if(index != 3){
                      index = 3;
                      setState(() {

                      });
                    }
                  },
                  child: Icon(Icons.settings, color: AppColors.white,size: index == 3? selectedSize : unSelectedSize,)),
              InkWell(
                  onTap: (){
                    if(index != 4){
                      index = 4;
                      setState(() {

                      });
                    }
                  },
                  child: Icon(Icons.menu_open, color: AppColors.white,size: index == 4? selectedSize : unSelectedSize,)),
            ],
          ),
        ),
      ),
    );
  }
}
