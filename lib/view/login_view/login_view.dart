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
                children: [
                  AppBackGroundTwoContainer(
                    blueContainerWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox(hei: getViewPadding(context).top),
                        Center(child: SvgPicture.asset(AppImages.logoAndName)),
                        Text(
                          AppStrings.login,
                          style: AppStyle.whiteBold30,
                        ),
                        sizedBox(hei: 10),
                        Text(
                          AppStrings.loginSubTitle,
                          style: AppStyle.whiteMedium16,
                        ),
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
                    ),
                  ),
                  Column(
                    children: [
                      sizedBox(hei: getFullHeight(context) * .3),
                      Consumer<LoginViewModel>( builder: (context, provider, child) {
                        return Form(
                          key: provider.formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 400,
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: AppColors.black, width: 0.15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).canvasColor,
                                      blurRadius: 2,
                                      spreadRadius: 1),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.login,
                                    style: AppStyle.primaryColorDarkMedium25(
                                        context),
                                  ),
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: provider.mailCont,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: AppStyle.primaryColorDarkMedium16(
                                        context),
                                    focusNode: provider.emailFocusNode,
                                    validator: Utils.isValidEmail,
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.emailFocusNode,
                                          provider.passFocusNode);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.black)),
                                      hintText: AppStrings.enterEmailAddress,
                                      hintStyle:
                                          AppStyle.primaryColorDarkMedium16(
                                              context),
                                      label: const Text(AppStrings.yourEmail),
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      labelStyle:
                                          AppStyle.primaryColorDarkMedium16(
                                              context),
                                      hoverColor: AppColors.blueAccent,
                                      disabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.black)),
                                    ),
                                  ),
                                  sizedBox(hei: 20),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.done,
                                    controller: provider.passCont,
                                    style: AppStyle.primaryColorDarkMedium16(
                                        context),
                                    focusNode: provider.passFocusNode,
                                    validator: Utils.isValidPass,
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.passFocusNode,
                                          provider.buttonFocusNode);
                                    },
                                    obscuringCharacter: "*",
                                    obscureText: provider.obsText,
                                    decoration: InputDecoration(
                                        labelStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        prefixIcon: Icon(
                                          Icons.lock_open,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              provider.passShowHide();
                                            },
                                            child: Icon(
                                              provider.obsText
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            )),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
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
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.forgetPasswordView);
                                          },
                                          child: Text(
                                            AppStrings.forgetPassword,
                                            style: AppStyle
                                                .primaryColorDarkMedium16(
                                                    context),
                                          )),
                                    ],
                                  ),
                                  sizedBox(hei: 20),
                                  AppRoundedButton(
                                    isEnable: !provider.loading,
                                    focusNode: provider.buttonFocusNode,
                                    loading: provider.loading,
                                    onTap: () {
                                      provider.setLoading(true);
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
        ),
      ),
    );
  }
}
