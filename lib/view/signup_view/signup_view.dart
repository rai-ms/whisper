import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/view/signup_view/widgets/bottom_sheet.dart';
import '../../components/app_dialog.dart';
import '../../components/background_app.dart';
import '../../global/global.dart';
import 'package:provider/provider.dart';
import '../../res/components/app_rounded_button.dart';
import '../../utils/app_helper/app_color.dart';
import '../../utils/app_helper/app_image.dart';
import '../../utils/app_helper/app_strings.dart';
import '../../utils/app_helper/app_style.dart';
import '../../utils/utils.dart';
import '../../view_model/signup_view_model/signup_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String email = "", pass = "";

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).viewPadding.top;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ],
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: getFullWidth(context),
            child: Stack(
              children: [
                SizedBox(
                  height: getFullHeight(context),
                  width: getFullWidth(context),
                  child: AppBackGroundTwoContainer(
                    blueContainerWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizedBox(hei: paddingTop - 20),
                        SvgPicture.asset(AppImages.logoAndName),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.signUp,
                                style: AppStyle.whiteBold30,
                              ),
                              sizedBox(hei: 5),
                              Text(
                                AppStrings.subtitleSignup,
                                style: AppStyle.whiteMedium16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    whiteContainerWidget: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    ),
                  ),
                ),
                Consumer<SignUpViewModel>(
                  builder: (context, provider, child) {
                    return Form(
                      key: provider.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizedBox(hei: getFullHeight(context) * .23),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                children: [
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: provider.nameCont,
                                    readOnly: provider.readOnly,
                                    focusNode: provider.nameFocusNode,
                                    validator: (_) {
                                      return null;
                                    },
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.nameFocusNode,
                                          provider.usernameFocusNode);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
                                        hintText: AppStrings.provideName,
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        labelStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        label:
                                            const Text(AppStrings.provideName),
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        hoverColor: AppColors.blueAccent),
                                  ),
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: provider.usernameCont,
                                    readOnly: provider.readOnly,
                                    focusNode: provider.usernameFocusNode,
                                    validator: (_) {
                                      return null;
                                    },
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.usernameFocusNode,
                                          provider.emailFocusNode);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        labelStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        hintText: AppStrings.provideUsername,
                                        label: const Text(AppStrings.username),
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        hoverColor: AppColors.blueAccent),
                                  ),
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: provider.emailCont,
                                    readOnly: provider.readOnly,
                                    focusNode: provider.emailFocusNode,
                                    validator: Utils.isValidEmail,
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.emailFocusNode,
                                          provider.passFocusNode);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        labelStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
                                        hintText: AppStrings.enterEmailAddress,
                                        label: const Text(AppStrings.yourEmail),
                                        constraints: BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        hoverColor: AppColors.blueAccent),
                                  ),
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: provider.passCont,
                                    readOnly: provider.readOnly,
                                    focusNode: provider.passFocusNode,
                                    validator: Utils.isValidPass,
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.passFocusNode,
                                          provider.confPassFocusNode);
                                    },
                                    obscuringCharacter: "*",
                                    obscureText: provider.obsText,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        labelStyle:
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
                                            child: Icon(provider.obsText
                                                ? Icons.visibility_outlined
                                                : Icons
                                                    .visibility_off_outlined)),
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
                                  sizedBox(hei: 15),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: provider.confPassCont,
                                    readOnly: provider.readOnly,
                                    focusNode: provider.confPassFocusNode,
                                    validator: Utils.isValidPass,
                                    onFieldSubmitted: (_) {
                                      Utils.changeFocus(
                                          context,
                                          provider.confPassFocusNode,
                                          provider.checkBoxFocusNode);
                                    },
                                    obscuringCharacter: "*",
                                    obscureText: provider.obsText,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        hintStyle:
                                            AppStyle.primaryColorDarkMedium16(
                                                context),
                                        labelStyle:
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
                                            child: Icon(provider.obsText
                                                ? Icons.visibility_outlined
                                                : Icons
                                                    .visibility_off_outlined)),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.black)),
                                        hintText: AppStrings.confirmPassword,
                                        label: const Text(
                                            AppStrings.reEnterPassword),
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        hoverColor: AppColors.blueAccent),
                                  ),
                                  sizedBox(hei: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          activeColor:
                                              AppColors.blueSplashScreen,
                                          value: provider.isCheckCheckBox,
                                          onChanged: (bool? isChecked) {
                                            provider.checkBoxToggle(
                                                isChecked!, context);
                                          },
                                          focusNode: provider.checkBoxFocusNode,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      child: AppDialog(
                                                          dialogWidget:
                                                              SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                AppStrings
                                                                    .privacyPolicyDetails,
                                                                style: AppStyle
                                                                    .whiteMedium16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                    ));
                                          },
                                          child: RichText(
                                              text: TextSpan(
                                                  style: AppStyle.blackNormal17,
                                                  children: [
                                                TextSpan(
                                                    text: AppStrings
                                                        .byRegistering,
                                                    style: AppStyle
                                                        .primaryColorDarkMedium(
                                                            context)),
                                                TextSpan(
                                                    text: AppStrings
                                                        .privacyPolicy,
                                                    style: AppStyle
                                                        .primaryColorDarkBold20(
                                                            context)),
                                                TextSpan(
                                                    text: AppStrings.and,
                                                    style: AppStyle
                                                        .primaryColorDarkMedium(
                                                            context)),
                                                TextSpan(
                                                    text: AppStrings.termsOfUse,
                                                    style: AppStyle
                                                        .primaryColorDarkBold20(
                                                            context)),
                                              ])),
                                        ),
                                      )
                                    ],
                                  ),
                                  sizedBox(hei: 10),
                                  AppRoundedButton(
                                    height: 50,
                                    width: 170,
                                    isEnable: provider.isCheckCheckBox,
                                    loading: provider.loading,
                                    focusNode: provider.loginButtonFocusNode,
                                    onTap: () {
                                      email = provider.emailCont.text
                                          .toString()
                                          .trim();
                                      pass = provider.passCont.text
                                          .toString()
                                          .trim();
                                      provider.createAccount(
                                          context, showBottomSheet);
                                    },
                                    title: AppStrings.createAccount,
                                    buttonColor: AppColors.blueSplashScreen,
                                    textColor: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                            sizedBox(hei: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(AppStrings.alreadyHaveAccount),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      AppStrings.logIn,
                                      style: AppStyle.blueItalicBoldUnderline15,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetVerifyAccount(
              mail: email,
              pass: pass,
            ));
  }
}
