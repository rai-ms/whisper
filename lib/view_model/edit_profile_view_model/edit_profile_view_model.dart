import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/profile_edit_payload.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../repository/edit_profile_repo/edit_profile_repo.dart';

class EditProfileViewModel extends ChangeNotifier {

  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  EditProfileRepository repository = EditProfileRepository();


  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool isPicked = false;
  File? pickedImage;

  final String _imgUrl = "https://lh3.googleusercontent.com/p/AF1QipOc4D_FziIEFMON03VmBkBcIbZJCVhRNgdbwuoJ=s1360-w1360-h1020";
  String get imgUrl => _imgUrl;

  fetchFromCamera() async {
    await requestPermission().then((value) async{
      await fetchImage(ImageSource.camera);
      notifyListeners();
    }).onError((error, stackTrace){
      debugPrint("Error while fetchFromCamera : $error");
    });
  }

  fetchFromGallery() async {
    await requestPermission().then((value) async {
      await fetchImage(ImageSource.gallery);
      notifyListeners();
    }).onError((error, stackTrace){
      debugPrint("Error while fetchFromGallery : $error");
    });
  }

  fetchImage(ImageSource source) async {
    try {
      XFile? pickImage = await ImagePicker().pickImage(
          source: source, maxHeight: 200, maxWidth: 300);
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
  }

  Future<void> uploadImage() async {
    if (!isPicked) {
      // return debugPrint("Image not Picked");
    } else {}
  }

  Future ediProfile() async {
    String newUsername = usernameController.text.toString().trim();
    String newBio = bioController.text.toString().trim();
    if(newUsername.isEmpty && newBio.isEmpty) return;
    await repository.editProfile(ProfileEditPayload(username: newUsername, profileBio: newBio)).then((value) async {
      debugPrint("Profile Updated Successfully in view model response is:$value");
      await UserData.updateBioUsernameProfilePic(newUsername:newUsername, newProfileBio:newBio,);
    }).onError((error, stackTrace){
      debugPrint("Profile Updated failed in view model error is:$error");
      throw AppError(error.toString());
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}