import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/sign_up_payload.dart';
import '../../repository/signup_repo/signup_repository.dart';
import '../../res/components/custom_toast.dart';
import '../../utils/app_helper/app_color.dart';
import '../../utils/app_helper/app_strings.dart';
import '../../utils/utils.dart';

class SignUpViewModel extends ChangeNotifier {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confPassCont = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode confPassFocusNode = FocusNode();
  FocusNode loginButtonFocusNode = FocusNode();
  FocusNode checkBoxFocusNode = FocusNode();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  bool isCheckCheckBox = false;
  bool obsText = false;


  passShowHide() {
    obsText = !obsText;
    notifyListeners();
  }


  checkBoxToggle(bool isChecked, BuildContext context){
    isCheckCheckBox = isChecked;
    if(isCheckCheckBox){
      Utils.changeFocus(context, checkBoxFocusNode, loginButtonFocusNode);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    emailCont.dispose();
    passCont.dispose();
    scaffoldKey.currentState!.dispose();
    confPassCont.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    confPassFocusNode.dispose();
    loginButtonFocusNode.dispose();
    formKey.currentState!.dispose();
    super.dispose();
  }

  createAccount(BuildContext context) async {
    setLoading(true);
    String passwordUser = passCont.text.toString().trim();
    String confPassUser = confPassCont.text.toString().trim();
    formKey.currentState!.save();
    // Validate Form
    if (passwordUser != confPassUser) {
      CustomToast(context: context, message: AppStrings.passwordNotMatched);
      Utils.changeFocus(context, passFocusNode, confPassFocusNode);
      setLoading(false);
    }
    else if (formKey.currentState!.validate() && confPassUser == passwordUser && isCheckCheckBox) {
      signUp(context);
      setLoading(false);
    }
    else {
      setLoading(false);
    }

  }

  bool isPicked = false;
  File? pickedImage;

  final String _imgUrl = "https://i.pinimg.com/750x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg";
  String get imgUrl => _imgUrl;

  fetchImage() async {
    try {
      XFile? pickImage = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 300);

      if (pickImage == null) return;
      final tmpImage = File(pickImage.path);
      pickedImage = tmpImage;
      isPicked = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.camera.request();
    // Check the permission status
    if (status.isGranted) {
      // debugPrint("Going to fetch Image");
      await fetchImage();
    } else {
      // debugPrint("Going to fetch Image in else");
      await fetchImage();
      // debugPrint("Image Fetched now going to upload in else");
      // await uploadImage();
      // debugPrint("Image Uploaded $_imgUrl in else");
      // openAppSettings();
    }
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (!isPicked) {
      // return debugPrint("Image not Picked");
    } else {}
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  final _myRepo = SignUpRepository();
  signUp(BuildContext context) {
    _myRepo.registrationAPI(SignUpPayloadModel(password: passCont.text.toString().trim(), email: emailCont.text.toString().trim()))
        .then((value){
      CustomToast(context: context, message: "SignUp Successfully Done $value");
      showBottomSheet();
      // setLoading(false);

    })
        .onError((error, stackTrace) {
      debugPrint("${AppStrings.errorOccured}:$error");
    });

  }


  void showBottomSheet() {
    scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        height: 200, // Adjust the height as needed
        color: AppColors.grey,
        child: Center(
          child: Text("Your content here"),
        ),
      );
    });
  }

}
