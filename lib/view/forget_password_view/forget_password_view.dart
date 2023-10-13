import 'package:flutter/material.dart';
import 'package:whisper/global/global.dart';

import '../../components/background_app.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: getFullHeight(context),
        width: getFullWidth(context),
        child:  Stack(
          children: [
            AppBackGroundTwoContainer(
              blueContainerWidget: SizedBox(),
              whiteContainerWidget: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
