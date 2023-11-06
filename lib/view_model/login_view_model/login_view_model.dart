import 'package:flutter/cupertino.dart';
import 'package:whisper/repository/login_repo/login_repo.dart';
import 'package:whisper/utils/deBouncer/deBouncer.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../model/user.dart';
import '../../res/components/custom_toast.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController mailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    mailCont.dispose();
    passFocusNode.dispose();
    passCont.dispose();
    emailFocusNode.dispose();
    // formKey.currentState!.dispose();
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

  final deBouncer = DeBouncer(
    milliseconds: 1000,
  );

  login(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      deBouncer.run(() async {
        await loginAPI(context);
      });
    }
  }

  final myLoginRepo = LoginRepository();

  Future<void> loginAPI(BuildContext context) async {
    dynamic data = {
      "email": mailCont.text.toString().trim(),
      "password": passCont.text.toString().trim()
    };
    await myLoginRepo.loginAPI(data).then((User? user) {
      CustomToast(context: context, message: "Login Successful");
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeView, (route) => false);
    }).onError((error, stackTrace) {
      debugPrint("Error is $error");
      CustomToast(context: context, message: "Error occur in API Call $error");
    });
    setLoading(false);
  }
}
