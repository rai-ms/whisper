import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});
  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  double? selectedSize = 35;
  double? unSelectedSize = 25;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: AppColors.blueSplashScreen),
          shape: BoxShape.rectangle
        ),
        child: Consumer<AppGlobalProvider>(
          builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                InkWell(
                    onTap: (){
                      if(index != 0){
                        index = 0;
                        provider.page = index;
                        setState((){});
                      }
                    },
                    child: Icon(FontAwesomeIcons.houseUser, color: AppColors.blueSplashScreen,size: index == 0? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                      if(index != 1){
                        index = 1;
                        provider.page = index;
                        setState((){});
                      }
                    },
                    child: Icon(FontAwesomeIcons.heart, color: AppColors.blueSplashScreen,size: index == 1? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                      if(index != 2){
                        index = 2;
                        provider.page = index;
                        setState((){});
                        Navigator.pushNamed(context, RouteName.addPostView);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueSplashScreen,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.add, color: AppColors.white,size:selectedSize! + 10,),
                    )),
                InkWell(
                    onTap: (){
                      if(index != 3){
                        index = 3;
                        provider.page = index;
                        setState((){});
                      }
                    },
                    child: Icon(Icons.search, color: AppColors.blueSplashScreen,size: index == 3? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                      if(index != 4){
                        index = 4;
                        provider.page = index;
                        setState((){});
                      }
                    },
                    child: ClipOval(child: UtilityHelper.image("https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60", height: index == 4? (selectedSize!+10.0) : unSelectedSize! + 5))),
              ],
            );
          }
        ),
      );
  }
}

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2.0;
    const notchRadius = 20.0; // Adjust the radius as needed

    path.moveTo(0, 0);
    path.lineTo(centerX - notchRadius, 0);

    path.arcToPoint(
      Offset(centerX + notchRadius, 0),
      radius: const Radius.circular(notchRadius),
      clockwise: true,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomSheetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}




