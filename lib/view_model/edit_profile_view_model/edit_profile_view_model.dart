import 'package:flutter/cupertino.dart';

class EditProfileViewModel extends ChangeNotifier {

  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

}