import 'package:flutter/cupertino.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';
import 'package:whisper/utils/app_helper/user_data_prefrence/user_data.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../model/user.dart';
import '../../model/user_model.dart';
import '../../repository/auth_repository.dart';
import '../../res/components/custom_toast.dart';

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
    // formkey.currentState!.dispose();
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
    if (formkey.currentState!.validate()) {
      await loginAPI(context);
    }
  }

  final myLoginRepo = LoginRepository();
  Future<void> loginAPI(BuildContext context)async {
    setLoading(true);
    dynamic data = {
      "email": mailCont.text.toString().trim(),
      "password": passCont.text.toString().trim()
    };
    myLoginRepo.loginAPI(data).then((User? user){
      CustomToast(context: context, message: "Login Successful");
      setLoading(false);
      Navigator.pushNamedAndRemoveUntil(context, RouteName.homeView, (route) => false);
    }).onError((error, stackTrace){
      debugPrint("Error is $error");
      // CustomToast(context: context, message:"Error occur in API Call $error");
      setLoading(false);
    });
  }

}
