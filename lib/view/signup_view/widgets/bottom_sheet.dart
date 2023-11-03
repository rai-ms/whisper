import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../../utils/app_helper/app_image.dart';
import '../../../utils/app_helper/app_strings.dart';

class BottomSheetVerifyAccount extends StatefulWidget {
  const BottomSheetVerifyAccount(
      {super.key, required this.mail, required this.pass});
  final String mail;
  final String pass;
  @override
  State<BottomSheetVerifyAccount> createState() =>
      _BottomSheetVerifyAccountState();
}

class _BottomSheetVerifyAccountState extends State<BottomSheetVerifyAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      width: getFullWidth(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.verifyMailLogo),
            sizedBox(hei: 10),
            const Text(
              AppStrings.verifyYourMail,
              textAlign: TextAlign.center,
            ),
            sizedBox(hei: 15),
            AppRoundedButton(
              onTap: () {
                Navigator.pushReplacementNamed(context, RouteName.otpAuthView,
                    arguments: {"mail": widget.mail, 'password': widget.pass});
              },
              title: AppStrings.verify,
              textStyle: AppStyle.blueSplashBold20,
              borderWidth: 2,
              borderColor: AppColors.blueSplashScreen,
              isEnable: true,
              buttonColor: AppColors.white,
              loading: false,
            )
          ],
        ),
      ),
    );
  }
}
