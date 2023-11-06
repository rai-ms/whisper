import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whisper/aws/aws_upload.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/profile_edit_payload.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../repository/edit_profile_repo/edit_profile_repo.dart';

class EditProfileViewModel extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
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

  String? _imgUrl;
  String get imgUrl => _imgUrl!;

  fetchFromCamera() async {
    await requestPermission().then((value) async {
      await fetchImage(ImageSource.camera);
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint("Error while fetchFromCamera : $error");
    });
  }

  fetchFromGallery() async {
    await requestPermission().then((value) async {
      await fetchImage(ImageSource.gallery);
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint("Error while fetchFromGallery : $error");
    });
  }

  fetchImage(ImageSource source) async {
    try {
      XFile? pickImage = await ImagePicker()
          .pickImage(source: source, maxHeight: 200, maxWidth: 300);
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
      return debugPrint("Image not Picked");
    } else {
      String? userid = await UserData.getUserId();
      _imgUrl = await S3Services().upload(file: pickedImage!, userid: userid!);
    }
  }

  String? ifUploadProfileUrl;

  Future ediProfile() async {
    String? username = await UserData.getUserUsername();
    String? bio = await UserData.getBio();
    String? fullName = await UserData.getFullName();
    String? newUsername = usernameController.text.toString().trim();
    String? newBio = bioController.text.toString().trim();
    String? newFullName = fullNameController.text.toString().trim();
    if (newUsername.isEmpty && newBio.isEmpty && !isPicked && newFullName.isEmpty) return;
    if (isPicked) {
      await uploadImage();
      ifUploadProfileUrl = _imgUrl;
    } else {
      ifUploadProfileUrl = null;
    }
    if (newBio == bio) newBio = null;
    if (newUsername == username) newUsername = null;
    if (newFullName == fullName) newFullName = null;
    await repository.editProfile(ProfileEditPayload(username: newUsername, profileBio: newBio, profilePic: ifUploadProfileUrl, fullName: newFullName))
        .then((value) async {
      // debugPrint("Profile Updated Successfully in view model response is:$value");
      await UserData.updateBioUsernameProfilePicFullName(newUsername: newUsername, newProfileBio: newBio, newProfilePic: ifUploadProfileUrl, newFullName: newFullName).then((value){}).onError((error, stackTrace){});
      pickedImage = null;
      isPicked = false;
    }).onError((error, stackTrace) {
      // debugPrint("Profile Updated failed in view model error is:$error");
      throw AppError(error.toString());
      pickedImage = null;
      isPicked = false;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    bioController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
