import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
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
        print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static CachedNetworkImage image(img, {double? height, double? width,String? placeHolderImage,File? file,BoxFit? fit, bool cachedExtent = true}) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      memCacheHeight: cachedExtent ? 250 : null,
      memCacheWidth: cachedExtent ? 250 : null,
      fit: fit ?? BoxFit.contain,
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
                placeHolderImage ?? AppImages.tapOnLogo,
                height: height ?? 40,
                width: width ?? 40,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
