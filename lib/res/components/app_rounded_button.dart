import 'package:flutter/material.dart';
import '../../utils/app_helper/app_color.dart';

class AppRoundedButton extends StatelessWidget {
  /// [title] is a text of the [AppRoundedButton] which will be visible when [loading] will be false
  String title;

  /// [onTap] is a [VoidCallback] method of the [AppRoundedButton]
  VoidCallback onTap;

  /// [loading] is a loading of the [AppRoundedButton] which is  by default false, means [loadingWidget] won't be visible
  bool loading;

  /// [focusNode] is a focus of the [AppRoundedButton]
  FocusNode? focusNode;

  /// [buttonColor] is a color of the button of the [AppRoundedButton] which is by default [AppColors.blueSplashScreen]
  Color? buttonColor = AppColors.blueSplashScreen;

  /// [textColor] is a color of the text within the [AppRoundedButton]
  Color? textColor = AppColors.white;

  /// [height], [width], [borderWidth] is a button height , width and border color width
  double? height, width, borderWidth;

  /// [borderColor] is a button border color
  Color? borderColor;

  /// [textStyle] is a style of the text within the [AppRoundedButton]
  TextStyle? textStyle;

  /// [loadingWidget] is a widget which have [CircularProgressIndicator] in default, and can be assign any custom widget to show while loading
  Widget loadingWidget;

  /// [isEnable] can be use to enable or disable button
  bool isEnable;

  /// Custom App Button used for multipurpose in the app
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
      this.loadingWidget = const CircularProgressIndicator(
        color: AppColors.white,
      ),
      this.isEnable = true,
      this.textStyle,
      this.borderWidth,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isEnable) {
          onTap();
        }
      },
      focusNode: focusNode,
      child: Container(
        height: height ?? 60,
        width: width ?? 200,
        decoration: BoxDecoration(
            color: isEnable ? buttonColor : AppColors.grey,
            borderRadius: BorderRadius.circular(20),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: borderWidth ?? 1)
                : Border.all()),
        child: Center(
            child: loading
                ? loadingWidget
                : Text(
                    title,
                    style: textStyle ??
                        TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                  )),
      ),
    );
  }
}
