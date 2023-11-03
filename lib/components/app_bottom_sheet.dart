import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper/global/global.dart';
import '../utils/app_helper/app_color.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key, this.bottomSheetWidget});
  final Widget? bottomSheetWidget;
  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: getFullWidth(context) - 30,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: SizedBox(
        child: IconTheme(
            data: const IconThemeData(color: AppColors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [Expanded(child: widget)],
              ),
            )),
      ),
    );
  }
}
