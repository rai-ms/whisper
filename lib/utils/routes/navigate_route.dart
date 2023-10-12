import 'package:flutter/material.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../view/home_view/home_view.dart';
import '../../view/intro_view/intro_view.dart';
import '../../view/login_view/login_view.dart';
import '../../view/otp_auth_view/otp_auth_view.dart';
import '../../view/signup_view/signup_view.dart';
import '../../view/splash_view/splash_view.dart';

class NavigateRoute {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashscreen:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RouteName.homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RouteName.introView:
        return MaterialPageRoute(builder: (context) => const IntroView());
      case RouteName.signupView:
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RouteName.otpAuthView:
        Map<String, dynamic> mp = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => OTPAuthView(mail: mp["email"], password: mp['password'],));
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text("Error 404"),
              ),
            ));
    }
  }
}
