import 'package:flutter/material.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view/forget_password_view/forget_password_view.dart';
import 'package:whisper/view/settings_view/settings_view.dart';
import '../../view/add_post_view/add_post_view.dart';
import '../../view/edit_profile_view/edit_profile_view.dart';
import '../../view/home_view/home_view.dart';
import '../../view/intro_view/intro_view.dart';
import '../../view/login_view/login_view.dart';
import '../../view/otp_auth_view/otp_auth_view.dart';
import '../../view/post_details_view/post_details_view.dart';
import '../../view/profile_view/profile_view.dart';
import '../../view/signup_view/signup_view.dart';
import '../../view/splash_view/splash_view.dart';
import '../../view/third_user_profile_view/third_user_profile_view.dart';

class NavigateRoute {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashscreen:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RouteName.settingsView:
        return MaterialPageRoute(builder: (context) => const SettingsView());
      case RouteName.homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RouteName.forgetPasswordView:
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordView());
      case RouteName.introView:
        return MaterialPageRoute(builder: (context) => const IntroView());
      case RouteName.signupView:
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RouteName.addPostView:
        return MaterialPageRoute(builder: (context) => const AddPostView());
      case RouteName.profileView:
        return MaterialPageRoute(builder: (context) => const ProfileView());
      case RouteName.editProfileView:
        return MaterialPageRoute(builder: (context) => const EditProfileView());
      case RouteName.otpAuthView:
        Map<String, dynamic> mp = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => OTPAuthView(
                mail: mp["mail"],
                password: mp['password'],
                isForgetPass: mp['isForgetPass'] ?? false));
      case RouteName.postDetailsView:
        Map<String, dynamic> mp = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => PostDetailsView(
            postId: mp['postId'],
            isLiked: mp['isLiked'],
          ),
        );
      case RouteName.thirdUserProfileView:
        Map<String, dynamic> mp = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ThirdUserProfileView(
                  id: mp['id'],
                ));
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
