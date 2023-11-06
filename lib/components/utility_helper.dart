import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import '../utils/app_helper/app_image.dart';

class UtilityHelper {
  // static void toastMessage(message) {
  //   var snackBar = SnackBar(
  //       elevation: 7.0,
  //       behavior: SnackBarBehavior.floating,
  //       duration: const Duration(milliseconds: 1500),
  //       backgroundColor: Colors.black,
  //       content: Container(
  //           margin: const EdgeInsets.symmetric(vertical: 10),
  //           child: Text(
  //             message,
  //             style: const TextStyle(color: Colors.white),
  //           )));
  //   navigatorScaffoldKey.currentState?.showSnackBar(snackBar);
  // }

  // Check Internet
  static Future<bool> isInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      return false;
    }
  }

  static CachedNetworkImage image (img, {double? height, double? width, String? placeHolderImage, File? file, BoxFit fit = BoxFit.fill, bool cachedExtent = true, Widget Function(BuildContext, String)? placeholder}) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      placeholder: placeholder ??
          (context, url) => Center(
                child: Container(
                  decoration: const BoxDecoration(color: AppColors.grey),
                ),
              ),
      memCacheHeight: cachedExtent ? 250 : null,
      memCacheWidth: cachedExtent ? 250 : null,
      fit: fit,
      errorWidget: (context, url, error) => Container(
        color: Colors.white,
        child: file != null
            ? Image.file(
                file,
                height: height ?? 40,
                width: width ?? 40,
                fit: BoxFit.contain,
              )
            : Image.asset(
                placeHolderImage ?? AppImages.profileBackground,
                height: height ?? 40,
                width: width ?? 40,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  static Widget fadedImage({required String image}){
    String dpImage = image;
    if(dpImage.isEmpty) dpImage = dp!;
    return FadeInImage.assetNetwork(
      placeholder: AppImages.logoAndName,
      image: dpImage,
    );
  }
}
