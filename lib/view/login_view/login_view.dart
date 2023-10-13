import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_image.dart';
import '../../components/background_app.dart';
import '../../global/global.dart';
import '../../res/components/app_rounded_button.dart';
import '../../utils/app_helper/app_color.dart';
import '../../utils/app_helper/app_strings.dart';
import '../../utils/app_helper/app_style.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_model/login_view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: getFullHeight(context),
            width: getFullHeight(context),
            child: Stack(
              children:
              [
                AppBackGroundTwoContainer(
                  blueContainerWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(hei: getViewPadding(context).top),
                      Center(child: SvgPicture.asset(AppImages.logoAndName)),
                      Text(AppStrings.login, style: AppStyle.whiteBold30,),
                      sizedBox(hei: 10),
                      Text(AppStrings.loginSubTitle, style: AppStyle.whiteMedium16,),
                    ],
                  ),
                  whiteContainerWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.signupView);
                        },
                        child: RichText(
                          text: TextSpan(
                            style: AppStyle.blackBold16,
                            children: const <TextSpan>[
                              TextSpan(
                                text: AppStrings.dontHaveAccount,
                              ),
                              TextSpan(
                                  text: AppStrings.signUp,
                                  style: TextStyle(
                                    color: AppColors.blue,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      sizedBox(hei: getViewPadding(context).top),
                    ],
                  ),),
                Column(
                  children: [
                    sizedBox(hei: getFullHeight(context)*.3),
                    Consumer<LoginViewModel>(builder: (context, provider, child) {
                      return Form(
                        key: provider.formkey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 400,
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: AppColors.black, width: 0.15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.login,
                                  style: AppStyle.blueBold20,
                                ),
                                sizedBox(hei: 15),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: provider.mailCont,
                                  focusNode: provider.emailFocusNode,
                                  validator: Utils.isValidEmail,
                                  onFieldSubmitted: (_) {
                                    Utils.changeFocus(context, provider.emailFocusNode,
                                        provider.passFocusNode);
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: AppColors.blueSplashScreen,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide:
                                          BorderSide(width: 2, color: AppColors.black)),
                                      hintText: AppStrings.enterEmailAddress,
                                      label: Text(AppStrings.yourEmail),
                                      constraints: BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      hoverColor: AppColors.blueAccent),
                                ),
                                sizedBox(hei: 20),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  controller: provider.passCont,
                                  focusNode: provider.passFocusNode,
                                  validator: Utils.isValidPass,
                                  onFieldSubmitted: (_) {
                                    Utils.changeFocus(context, provider.passFocusNode,
                                        provider.buttonFocusNode);
                                  },
                                  obscuringCharacter: "*",
                                  obscureText: provider.obsText,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock_open,
                                        color: AppColors.blueSplashScreen,
                                      ),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            provider.passShowHide();
                                          },
                                          child: Icon(provider.obsText
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined)),
                                      border: const OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide:
                                          BorderSide(width: 2, color: AppColors.black)),
                                      hintText: AppStrings.pass,
                                      label: const Text(AppStrings.pass),
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      hoverColor: AppColors.blueAccent),
                                ),
                                sizedBox(hei: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        Navigator.pushNamed(context, RouteName.forgetPasswordView);
                                      },
                                      child: Text(AppStrings.forgetPassword, style: AppStyle.blueItalicBold15,)),
                                  ],
                                ),
                                sizedBox(hei: 20),
                                AppRoundedButton(
                                  loadingWidget: const CircularProgressIndicator(),
                                  isEnable: !provider.loading,
                                  focusNode: provider.buttonFocusNode,
                                  loading: provider.loading,
                                  onTap: () {
                                    provider.login(context);
                                  },
                                  title: AppStrings.login,
                                  buttonColor: AppColors.blueSplashScreen,
                                  textColor: AppColors.white,
                                ),
                                sizedBox(hei: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
