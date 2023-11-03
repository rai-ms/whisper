import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whisper/model/login_payload.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/user_data_preferences/user_data.dart';
import '../../aws/aws_upload.dart';
import '../../model/post_model.dart';

class AddPostViewModel extends ChangeNotifier {
  TextEditingController postContentCont = TextEditingController();
  FocusNode postContentFocusNode = FocusNode();
  int postContentLineCount = 7;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool isPicked = false;
  File? pickedImage;

  String? _imgUrl =
      "https://lh3.googleusercontent.com/p/AF1QipOc4D_FziIEFMON03VmBkBcIbZJCVhRNgdbwuoJ=s1360-w1360-h1020";
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
      // return debugPrint("Image not Picked");
    } else {}
  }

  var postRepo = PostRepository();

  Future uploadMyPost(BuildContext context) async {
    setLoading(true);
    String caption = postContentCont.text.toString().trim();
    bool isCaption = caption.isNotEmpty;
    String? userId = await UserData.getUserId();

    if (isPicked) {
      _imgUrl = await S3Services().upload(file: pickedImage!, userid: userId!);
      debugPrint("Image Url Received Success $_imgUrl");
      await postRepo
          .createPost(
              PostPayload(url: _imgUrl!, caption: isCaption ? caption : null))
          .then((ApiResponsePostCreatedModel? res) {
        if (res!.statusCode == 200) {
          CustomToast(message: "Post Uploaded Successfully", context: context);
          postContentCont.clear();
          isPicked = false;
          Navigator.pop(context);
        } else {
          debugPrint("Error");
        }
        setLoading(false);
      }).onError((error, stackTrace) {
        debugPrint("Post Upload failed");
        setLoading(false);
      });
    }
  }

  @override
  void dispose() {
    postContentCont.dispose();
    postContentFocusNode.dispose();
    super.dispose();
  }
}
