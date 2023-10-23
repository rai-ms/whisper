import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/model/payloads.dart';
import 'package:whisper/repository/post_repo/post_repo.dart';
import 'package:whisper/res/components/custom_toast.dart';

import '../../model/response.dart';

class AddPostViewModel extends ChangeNotifier
{
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
    // Check the permission status
    // if (status.isGranted) {
    // debugPrint("Going to fetch Image");
    // await fetchImage();
    // } else {
    //   // debugPrint("Going to fetch Image in else");
    //   await fetchImage();
    //   // debugPrint("Image Fetched now going to upload in else");
    //   // await uploadImage();
    //   // debugPrint("Image Uploaded $_imgUrl in else");
    //   // openAppSettings();
    // }
  }

  Future<void> uploadImage() async {
    if (!isPicked) {
      // return debugPrint("Image not Picked");
    } else {}
  }

  var postRepo = PostRepository();

  uploadMyPost(BuildContext context) async {
    setLoading(true);
    String caption = postContentCont.text.toString().trim();
    bool isCaption = caption.isNotEmpty;
    if(isPicked){
      await postRepo.createPost(PostPayload(url: _imgUrl, caption : isCaption? caption :null)).then((PostResponse? postResponse){
        if(postResponse!.statusCode == 200){
          CustomToast(message: "Post Uploaded Successfully", context: context);
          postContentCont.clear();
          isPicked = false;
          Navigator.pop(context);
        }
        else {
          debugPrint("Error");
        }
        setLoading(false);
      }).onError((error, stackTrace){
        debugPrint("Post Upload failed");
        setLoading(false);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    postContentCont.dispose();
    postContentFocusNode.dispose();
    super.dispose();
  }

}