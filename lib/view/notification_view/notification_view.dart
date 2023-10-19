import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.notification, style: AppStyle.blackBold24,),
              ],
            ),
          ),
          sizedBox(hei: 10),
          Expanded(
            flex: 90,
            child: ListView.builder(itemBuilder: (context, index){
              return ListTile(
                title: const Text("Notification Content which contains Like, Share, Follow, Comment messages"),
                leading: ClipRRect(
                  child: UtilityHelper.image("https://cdn-icons-png.flaticon.com/512/25/25231.png")),
              );
            }, itemCount:30,),
          ),
          //   Expanded(
          //     flex: 90,
          //     child: ListView.builder(itemBuilder: (context, index){
          //       return ListTile(
          //         title: Shimmer.fromColors(enabled: false,period: const Duration(seconds: 25), baseColor: AppColors.grey, highlightColor: AppColors.transparent, child: Container(
          //           height: 60,
          //           decoration: BoxDecoration(
          //               color: AppColors.grey,
          //               borderRadius: BorderRadius.circular(20)
          //           ),
          //         )),
          //         leading: Shimmer.fromColors(period: const Duration(seconds: 5), baseColor: AppColors.grey, highlightColor: AppColors.transparent,
          //           child: const CircleAvatar(
          //           backgroundColor: AppColors.grey,
          //           radius: 30,
          //         )),
          //       );
          //     }, itemCount:10,),
          // ),
        ],
      ),
    );
  }

  // Widget placeHolder(BuildContext context, String url){
  //   return Shimmer.fromColors(enabled: false,period: const Duration(seconds: 25), baseColor: AppColors.grey, highlightColor: AppColors.transparent, child: Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //         color: AppColors.grey,
  //         borderRadius: BorderRadius.circular(20)
  //     ),
  //   ));
  // }
}
