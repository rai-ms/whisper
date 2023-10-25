import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/user_profile_response.dart';
import 'package:whisper/repository/profile_repo/profile_repo.dart';

class PersonalProfileViewModel extends ChangeNotifier {
  int _index = 0;
  // PageController profilePageController = PageController(
  //   initialPage: 0, keepPage: false, viewportFraction: 1,);

  set index(int val) {
    _index = val;
    // profilePageController.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

  int get index => _index;

}