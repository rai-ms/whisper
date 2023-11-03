import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../global/global.dart';
import '../../res/components/app_rounded_button.dart';
import '../../utils/app_helper/app_color.dart';
import '../../utils/app_helper/app_image.dart';
import '../../utils/app_helper/app_style.dart';
import '../../utils/routes/route_name.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});
  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  int pos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              pos = index;
              setState(() {});
            },
            controller: PageController(
              initialPage: 0,
              keepPage: false,
              viewportFraction: 1,
            ),
            pageSnapping: true,
            reverse: false,
            allowImplicitScrolling: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          sizedBox(hei: 50),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Text(
                              "Let's crack",
                              style: AppStyle.blackNormal36,
                            ),
                          ),
                          Text(
                            "Helps you to contact everyone with just easy way",
                            style: AppStyle.blackNormal15,
                          ),
                          Image.asset(AppImages.introPeople),
                        ],
                      ),
                      Positioned(
                        top: 80,
                        right: 30,
                        child: AppRoundedButton(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteName.loginView, (route) => false);
                          },
                          height: 60,
                          width: 60,
                          title: "Skip",
                          textStyle: AppStyle.blueBold20,
                          borderColor: AppColors.blueSplashScreen,
                          buttonColor: AppColors.white,
                          borderWidth: 2,
                          textColor: AppColors.blueSplashScreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 70),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.blueSplashScreen,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          LottieBuilder.asset(
                            "assets/lottie/intro.json",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Text(
                              "Chat with multiple people",
                              style: AppStyle.whiteMedium22,
                            ),
                          ),
                          Text(
                            "Just like you playing multiple games same time",
                            style: AppStyle.whiteMedium16,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Positioned(
                        right: 30,
                        child: AppRoundedButton(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteName.loginView, (route) => false);
                          },
                          height: 60,
                          width: 60,
                          title: "Skip",
                          textStyle: AppStyle.whiteBold20,
                          borderColor: AppColors.white,
                          buttonColor: AppColors.transparent,
                          borderWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.blueSplashScreen,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              "assets/lottie/hello.json",
                            ),
                            Text(
                              "Let's Start",
                              style: AppStyle.whiteBold30,
                            ),
                            Text(
                              "The Journey...",
                              style: AppStyle.whiteMedium16,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 148.0),
                            //   child: Text(
                            //     "With Us",
                            //     style: AppStyle.whiteBold20,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 78.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AppRoundedButton(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteName.loginView, (route) => false);
                            },
                            title: "Get Start",
                            buttonColor: AppColors.white,
                            textColor: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                dotsCount: 3,
                position: pos,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(25.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
