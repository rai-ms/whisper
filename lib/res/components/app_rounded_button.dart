import 'package:flutter/material.dart';

import '../../utils/app_helper/app_color.dart';

class AppRoundedButton extends StatelessWidget {
  String title;
  VoidCallback onTap;
  bool loading;
  FocusNode? focusNode;
  Color? buttonColor = AppColors.blueSplashScreen;
  Color? textColor = AppColors.white;
  double? height, width, borderWidth;
  Color? borderColor;
  TextStyle? textStyle;
  bool isEnable;
  AppRoundedButton(
      {super.key,
        this.buttonColor,
        required this.onTap,
        required this.title,
        this.textColor,
        this.focusNode,
        this.width,
        this.borderColor,
        this.height,
        this.isEnable = true,
        this.textStyle,
        this.borderWidth,
        this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(isEnable){
          onTap();
        }
      },
      focusNode: focusNode,
      child: Container(
        height:height?? 60,
        width: width??200,
        decoration: BoxDecoration(
            color: isEnable? buttonColor : AppColors.grey,
            borderRadius: BorderRadius.circular(20),
            border: borderColor!= null ? Border.all(color: borderColor!, width: borderWidth ?? 1) :Border.all()
        ),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
              color: AppColors.white,
            )
                : Text(
              title,
              style: textStyle ?? TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}
