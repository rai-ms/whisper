import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
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
                      if(pageViewNumber != 0){
                        provider.setPage(0);
                      }
                    },
                    child: Icon(FontAwesomeIcons.houseUser, color: pageViewNumber != 0? AppColors.blueSplashScreen : AppColors.red,size: pageViewNumber == 0? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                      if(pageViewNumber != 1){
                        provider.setPage(1);
                      }
                    },
                    child: Icon(pageViewNumber != 1? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart, color: pageViewNumber != 1? AppColors.blueSplashScreen : AppColors.red,size: pageViewNumber == 1? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                        Navigator.pushNamed(context, RouteName.addPostView);
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
                      if(pageViewNumber != 2){
                        provider.setPage(2);
                      }
                      // debugPrint("Tapped on index 2");
                    },
                    child: Icon(Icons.search, color: pageViewNumber != 2? AppColors.blueSplashScreen : AppColors.red,size: pageViewNumber == 2? selectedSize : unSelectedSize,)),
                InkWell(
                    onTap: (){
                      if(pageViewNumber != 3){
                        provider.setPage(3);
                      }
                      // debugPrint("Tapped on index 3");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blueSplashScreen, width:  pageViewNumber == 3?3:0),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: ClipOval(child: UtilityHelper.image("https://scontent.fdel72-1.fna.fbcdn.net/v/t39.30808-6/355482789_3551846318425242_4960182591060623934_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=XnnVIAFitkUAX_luQ-r&_nc_ht=scontent.fdel72-1.fna&oh=00_AfBOBvAf8MrWfdpbU1NSzWArdT4TUuEa7jMdk6awI1ZGhw&oe=65345EA0", height: pageViewNumber == 3? (selectedSize!+10.0) : unSelectedSize! + 5)))),
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




