import 'package:flutter/material.dart';
import '../utils/app_helper/app_color.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({super.key, required this.dialogWidget});
  final Widget dialogWidget;
  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.blueSplashScreen,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(child: widget.dialogWidget)],
      )),
    );
  }
}
