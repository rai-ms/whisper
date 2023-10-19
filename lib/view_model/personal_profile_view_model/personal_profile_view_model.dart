import 'package:flutter/cupertino.dart';
import 'package:whisper/utils/app_helper/user_data_prefrence/user_data.dart';

class PersonalProfileViewModel extends ChangeNotifier
{
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