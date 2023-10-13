import 'package:flutter/cupertino.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../model/user_model.dart';
import '../../repository/auth_repository.dart';
import '../../res/components/custom_toast.dart';
import '../../utils/app_helper/user_data/user_data.dart';

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
      setLoading(true);
      await loginAPI(context);
      setLoading(false);
    }
    // setLoading(false);
  }

  final _myRepo = AuthRepository();
  Future<void> loginAPI(BuildContext context)async {
    dynamic data = {
      "email": mailCont.text.toString().trim(),
      "password": passCont.text.toString().trim()
    };
    _myRepo.loginAPI(data).then((value){
      UserModel userModel = value as UserModel;
      CustomToast(context: context, message: "Login Successful");
      UserData.saveUser(userModel);
      debugPrint("Token is ${userModel.token}");
      Navigator.pushNamedAndRemoveUntil(context, RouteName.homeView, (route)=> false);
    }).onError((error, stackTrace){
      CustomToast(context: context, message:"Error occur in API Call:"+ error.toString());
    });
  }

}
