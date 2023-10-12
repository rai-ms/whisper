import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/view/signup_view/widgets/bottom_sheet.dart';
import '../../components/app_dialog.dart';
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

  String email = "";

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).viewPadding.top;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ],
      child: Scaffold(
          key: SignUpViewModel.scaffoldKey,
          body: Center(
            child: SizedBox(
              height: getFullHeight(context),
              width: getFullWidth(context),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: Container(
                            width: getFullWidth(context),
                            color: AppColors.blueSplashScreen,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                sizedBox(hei: paddingTop + 10),
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
                                      Text(
                                        AppStrings.enterEmailAndPassword,
                                        style: AppStyle.whiteMedium16,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(AppStrings.alreadyHaveAccount),
                                    InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text(AppStrings.logIn, style: AppStyle.blueItalicBoldUnderline15,)),
                                  ],
                                ),
                                sizedBox(hei: paddingTop)
                              ],
                            ),
                          )
                      ),
                    ],
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
                              sizedBox(hei: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: AppColors.black, width: 0.15),
                                  ),
                                  child: Column(
                                    children: [
                                      sizedBox(hei: 20),
                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        controller: provider.emailCont,
                                        readOnly: provider.readOnly,
                                        focusNode: provider.emailFocusNode,
                                        validator: Utils.isValidEmail,
                                        onFieldSubmitted: (_) {
                                          Utils.changeFocus(context, provider.emailFocusNode,
                                              provider.passFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
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
                                        textInputAction: TextInputAction.next,
                                        controller: provider.passCont,
                                        readOnly: provider.readOnly,
                                        focusNode: provider.passFocusNode,
                                        validator: Utils.isValidPass,
                                        onFieldSubmitted: (_) {
                                          Utils.changeFocus(context, provider.passFocusNode,
                                              provider.confPassFocusNode);
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
                                      sizedBox(hei: 20),
                                      TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: provider.confPassCont,
                                        readOnly: provider.readOnly,
                                        focusNode: provider.confPassFocusNode,
                                        validator: Utils.isValidPass,
                                        onFieldSubmitted: (_) {
                                          Utils.changeFocus(context, provider.confPassFocusNode,
                                              provider.checkBoxFocusNode);
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
                                            hintText: AppStrings.confirmPassword,
                                            label: const Text(AppStrings.reEnterPassword),
                                            constraints: const BoxConstraints(
                                              maxWidth: 400,
                                            ),
                                            hoverColor: AppColors.blueAccent),
                                      ),
                                      sizedBox(hei: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              activeColor: AppColors.blueSplashScreen,
                                              value: provider.isCheckCheckBox,
                                              onChanged: (bool? isChecked){
                                                provider.checkBoxToggle(isChecked!, context);
                                              },
                                              focusNode: provider.checkBoxFocusNode,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: InkWell(
                                              onTap: (){
                                                showDialog(context: context, builder: (context) => Dialog(child: AppDialog(context: context, dialogWidget: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(AppStrings.privacyPolicyDetails, style: AppStyle.whiteMedium16,),
                                                      ),
                                                    ],
                                                  ),
                                                )),));
                                              },
                                              child: RichText(
                                                  text: TextSpan(
                                                      style: AppStyle.blackNormal17,
                                                      children: [
                                                        const TextSpan(text: AppStrings.byRegistering),
                                                        TextSpan(text:AppStrings.privacyPolicy , style: AppStyle.blackBold17),
                                                        const TextSpan(text: AppStrings.and ),
                                                        TextSpan(text: AppStrings.termsOfUse, style: AppStyle.blackBold17),
                                                      ]
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      sizedBox(hei: 20),
                                      AppRoundedButton(
                                        isEnable: provider.isCheckCheckBox,
                                        loading: provider.loading,
                                        focusNode: provider.loginButtonFocusNode,
                                        onTap: () {
                                          email = provider.emailCont.text.toString().trim();
                                          provider.createAccount(context, showBottomSheet);
                                        },
                                        title: AppStrings.createAccount,
                                        buttonColor: AppColors.blueSplashScreen,
                                        textColor: AppColors.white,
                                      )
                                    ],
                                  ),
                                ),
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
          )),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) => BottomSheetVerifyAccount(mail: email));
  }
}
