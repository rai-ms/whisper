import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/profile_edit_payload.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../repository/edit_profile_repo/edit_profile_repo.dart';

class EditProfileViewModel extends ChangeNotifier {

  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  EditProfileRepository repository = EditProfileRepository();

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