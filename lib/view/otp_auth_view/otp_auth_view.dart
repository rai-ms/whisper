import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_image.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import '../../components/background_app.dart';
import '../../view_model/otp_auth_view_model/otp_auth_view_model.dart';

class OTPAuthView extends StatefulWidget {
  const OTPAuthView({super.key, required this.mail, required this.password, this.isForgetPass = false});

  final String mail;
  final String password;
  final bool isForgetPass;

  @override
  State<OTPAuthView> createState() => _OTPAuthViewState();
}

class _OTPAuthViewState extends State<OTPAuthView> {

  @override
  Widget build(BuildContext context) {
    double padTop = getViewPadding(context).top;
    return MultiProvider(
      providers:
      [
        ChangeNotifierProvider(create: (context)=> OTPAuthViewModel()),
      ], 
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: getFullHeight(context),
            width: getFullWidth(context),
            child: Stack(
              children: [
                AppBackGroundTwoContainer(blueContainerWidget: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      sizedBox(hei: padTop),
                      SvgPicture.asset(AppImages.logoAndName),
                      sizedBox(hei: 20),
                      Row(
                        children: [
                          Text(AppStrings.otpAuth, style: AppStyle.whiteBold20,textAlign: TextAlign.start,),
                        ],
                      ),
                      sizedBox(hei: 10),
                      Text("Please enter 4-digits code sent to your Email ${widget.mail}.", style: AppStyle.whiteMedium16,textAlign: TextAlign.start,),
                    ],
                  ),
                ),whiteContainerWidget: sizedBox(),),
                // Column(
                //   children: [
                //     Expanded(
                //       flex: 2,
                //       child: Container(
                //         width: getFullWidth(context),
                //         decoration: const BoxDecoration(
                //           color: AppColors.blueSplashScreen,
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(28.0),
                //           child: Column(
                //             children: [
                //               sizedBox(hei: padTop),
                //               SvgPicture.asset(AppImages.logoAndName),
                //               sizedBox(hei: 20),
                //               Row(
                //                 children: [
                //                   Text(AppStrings.otpAuth, style: AppStyle.whiteBold20,textAlign: TextAlign.start,),
                //                 ],
                //               ),
                //               sizedBox(hei: 10),
                //               Text("Please enter 4-digits code sent to your Email ${widget.mail}.", style: AppStyle.whiteMedium16,textAlign: TextAlign.start,),
                //             ],
                //           ),
                //         ),
                //       )
                //     ),
                //     Expanded(
                //       flex: 3,
                //       child: Container(
                //
                //       )
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: AppColors.black, width: 0.15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          children: [
                            sizedBox(hei: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Verify for ${widget.mail}", style: AppStyle.blackMedium16,),
                                sizedBox(),
                              ],
                            ),
                            sizedBox(hei: 20),
                            Consumer<OTPAuthViewModel>(
                              builder: (context, provider, child) {
                                return Column(
                                  children: [
                                    OtpTextField(
                                      keyboardType: TextInputType.number,
                                      numberOfFields: 4,
                                      borderColor: AppColors.blueSplashScreen,
                                      showFieldAsBox: true,
                                      fieldWidth: 60,
                                      onCodeChanged: (String code)  {
                                        provider.isValidOTP = code.length == 4;
                                        debugPrint(code);
                                      },
                                      onSubmit: (String verificationCode){
                                        provider.otp = verificationCode;
                                        provider.sendOTPForVerification(widget.isForgetPass);
                                      }, // end onSubmit
                                    ),
                                    Text(provider.isValidOTP? AppStrings.emptyString : "Enter a Valid OTP", style: AppStyle.redMedium12,),
                                  ],
                                );
                              }
                            ),
                            sizedBox(hei: 20),
                            Consumer<OTPAuthViewModel>(
                              builder: (context, provider, child){
                                provider.startTimer();
                                return AppRoundedButton(
                                  isEnable: provider.enableButton,
                                  loading: !provider.enableButton,
                                  loadingWidget: Text("Resend OTP \n${provider.sec} seconds", textAlign: TextAlign.center,),
                                  onTap: (){
                                    provider.resendOTP();
                                  },
                                  title: AppStrings.resendOtp);
                              }
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


