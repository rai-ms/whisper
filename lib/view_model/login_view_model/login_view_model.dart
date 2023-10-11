import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController mailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void dispose() {
    mailCont.dispose();
    passFocusNode.dispose();
    passCont.dispose();
    emailFocusNode.dispose();
    formkey.currentState!.dispose();
    buttonFocusNode.dispose();

    super.dispose();
  }

  bool _obsText = false;
  bool get obsText => _obsText;
  passShowHide() {
    _obsText = !_obsText;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  login(BuildContext context) async {
    formkey.currentState!.save();
    if (formkey.currentState!.validate()) {}
  }
}
