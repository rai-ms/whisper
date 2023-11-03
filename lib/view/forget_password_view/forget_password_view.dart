import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_image.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/forget_password_view_model/forget_password_view_model.dart';
import '../../components/background_app.dart';
import '../../res/components/app_rounded_button.dart';
import '../../utils/app_helper/app_color.dart';
import '../../utils/app_helper/app_strings.dart';
import '../../utils/utils.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});
  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ForgetPasswordViewModel())
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: getFullHeight(context),
            width: getFullWidth(context),
            child: Stack(
              children: [
                AppBackGroundTwoContainer(
                  blueContainerWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(hei: getViewPadding(context).top),
                      Center(child: SvgPicture.asset(AppImages.logoAndName)),
                      sizedBox(hei: 10),
                      Text(
                        AppStrings.forgetPassword,
                        style: AppStyle.whiteBold30,
                      ),
                      sizedBox(hei: 10),
                      Text(
                        AppStrings.enterEmailAssociated,
                        style: AppStyle.whiteMedium16,
                      ),
                    ],
                  ),
                  whiteContainerWidget: SizedBox(),
                ),
                Column(
                  children: [
                    sizedBox(hei: getFullHeight(context) * .3),
                    Consumer<ForgetPasswordViewModel>(
                        builder: (context, provider, child) {
                      return Form(
                        key: provider.formkey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: AppColors.black, width: 0.15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                sizedBox(hei: 25),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: provider.mailCont,
                                  focusNode: provider.emailFocusNode,
                                  validator: Utils.isValidEmail,
                                  onFieldSubmitted: (_) {
                                    Utils.changeFocus(
                                        context,
                                        provider.emailFocusNode,
                                        provider.buttonFocusNode);
                                    provider.sendOTPForForgetPassword(context);
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: AppColors.blueSplashScreen,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.black)),
                                      hintText: AppStrings.enterEmailAddress,
                                      label: Text(AppStrings.yourEmail),
                                      constraints: BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      hoverColor: AppColors.blueAccent),
                                ),
                                sizedBox(hei: 25),
                                AppRoundedButton(
                                  isEnable: !provider.loading,
                                  focusNode: provider.buttonFocusNode,
                                  loading: provider.loading,
                                  onTap: () {
                                    provider.sendOTPForForgetPassword(context);
                                  },
                                  title: AppStrings.sendOTP,
                                  textStyle: AppStyle.whiteBold20,
                                  buttonColor: AppColors.blueSplashScreen,
                                  textColor: AppColors.white,
                                ),
                                sizedBox(hei: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
