import 'package:flutter/cupertino.dart';
import 'package:whisper/utils/routes/route_name.dart';

class ForgetPasswordViewModel extends ChangeNotifier
{
  TextEditingController mailCont = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey();
  bool loading = false;


  sendOTPForForgetPassword(BuildContext context) async {
    if(formkey.currentState!.validate()){
      loading = true;
      notifyListeners();

      try{
        await Future.delayed(const Duration(seconds: 2));
        loading = false;
        notifyListeners();
      }
      catch(e) {
        debugPrint(e.toString());
      }
      if(context.mounted)
      {
        Navigator.pushNamed(context, RouteName.otpAuthView, arguments: {'email':mailCont.text.toString().trim(), 'password':"", 'isForgetPass':true});
      }
    }
  }


  @override
  void dispose() {
    mailCont.dispose();
    buttonFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

}