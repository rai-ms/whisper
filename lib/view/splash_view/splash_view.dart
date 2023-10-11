import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../global/global.dart';
import '../../services/splashscreen_service.dart';
import '../../utils/app_helper/app_color.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    loading();
  }

  Future<void> loading() async {
    await SplashScreenServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: getFullHeight(context),
        width: getFullWidth(context),
        decoration: const BoxDecoration(color: AppColors.blueSplashScreen),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/lottie/splash_unity.json",
              height: 100,
              width: 100,
              repeat: true,
            )
          ],
        ),
      )),
    );
  }
}
