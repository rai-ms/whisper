import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/utils.dart';

class SignUpViewModel extends ChangeNotifier {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController confPassCont = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode confPassFocusNode = FocusNode();
  FocusNode loginButtonFocusNode = FocusNode();

  bool obsText = false;


  passShowHide() {
    obsText = !obsText;
    notifyListeners();
  }

  @override
  void dispose() {
    emailCont.dispose();
    passCont.dispose();
    nameCont.dispose();
    confPassCont.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    nameFocusNode.dispose();
    confPassFocusNode.dispose();
    loginButtonFocusNode.dispose();
    //formKey.currentState!.dispose();
    super.dispose();
  }

  emailFieldSubmitted(BuildContext context) {
    Utils.changeFocus(context, nameFocusNode, emailFocusNode);
  }

  createAccount(BuildContext context) async {
    setLoading(true);

    String emailUser = emailCont.text.toString().trim();
    String passwordUser = passCont.text.toString().trim();
    String nameUser = nameCont.text.toString().trim();
    String confPassUser = confPassCont.text.toString().trim();
    formKey.currentState!.save();
    // Validate Form
    if (formKey.currentState!.validate() && confPassUser == passwordUser) {}
    else if (passCont.text.toString().trim() != confPassCont.text.toString().trim()){}
    else{}
  }

  bool isPicked = false;
  File? pickedImage;
  String _imgUrl =
      "https://i.pinimg.com/750x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg";
  String get imgurl => _imgUrl;


  fetchImage() async
  {
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
      debugPrint("Going to fetch Image");
      await fetchImage();
    } else {
      debugPrint("Going to fetch Image in else");
      await fetchImage();
      debugPrint("Image Fetched now going to upload in else");
      // await uploadImage();
      debugPrint("Image Uploaded $_imgUrl in else");
      // openAppSettings();
    }
    notifyListeners();
  }

  Future<void> uploadImage() async
  {

  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
