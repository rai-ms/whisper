import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';

import '../../res/components/app_rounded_button.dart';
import '../../view_model/otp_auth_view_model/otp_auth_view_model.dart';

class OTPAuthView extends StatefulWidget {
  const OTPAuthView({super.key, required this.mail});

  final String mail;

  @override
  State<OTPAuthView> createState() => _OTPAuthViewState();
}

class _OTPAuthViewState extends State<OTPAuthView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> OTPAuthViewModel()),
      ], 
      child: Scaffold(
        body: SizedBox(
          height: getFullHeight(context),
          width: getFullWidth(context),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.blueSplashScreen,
                      ),
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                    )
                  ),
                ],
              ),
              Center(
                child: Container(

                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.black, width: 0.15),
                  ),
                  child: Column(
                    children: [
                      sizedBox(hei: 20),
                      sizedBox(hei: 20),
                      sizedBox(hei: 20),
                      sizedBox(hei: 20),
                      sizedBox(hei: 20),
                      AppRoundedButton(onTap: (){},title: "Submit OTP",)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
