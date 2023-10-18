import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/utils.dart';

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
                title: const Text("Notification Content which containes Like, Share, Follow, Comment messages"),
                leading: ClipRRect(
                  child: UtilityHelper.image("https://cdn-icons-png.flaticon.com/512/25/25231.png")),
              );
            }, itemCount:30,),
          )
        ],
      ),
    );
  }
}
