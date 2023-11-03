import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import '../utils/app_helper/app_color.dart';

class AppBackGroundTwoContainer extends StatelessWidget {
  const AppBackGroundTwoContainer(
      {super.key,
      this.blueContainerWidget = const SizedBox(),
      this.whiteContainerWidget = const SizedBox()});

  final Widget? blueContainerWidget;
  final Widget? whiteContainerWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              width: getFullWidth(context),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: blueContainerWidget,
              ),
            )),
        Expanded(flex: 3, child: whiteContainerWidget!),
      ],
    );
  }
}
