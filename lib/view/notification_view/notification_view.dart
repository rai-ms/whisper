import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_dialog.dart';
import 'package:whisper/components/loading_tile.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/repository/notification_repo/notification_repo.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/app_helper/toast_message.dart';
import 'package:whisper/view_model/notification_view_model/notification_view_model.dart';
import '../../components/utility_helper.dart';
import '../../utils/app_helper/app_enum.dart';
import '../../utils/app_helper/app_keys.dart';
import '../../utils/routes/route_name.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => NotificationViewModel())],
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    sizedBox(wid: 10),
                    Text(
                      AppStrings.notification,
                      style: AppStyle.blackBold24,
                    ),
                  ],
                ),
              ),
              sizedBox(hei: 10),
              Consumer<NotificationViewModel>(
                builder: (context, pr ,ch) {
                  return FutureBuilder(
                    future: pr.getAllNotification(),
                    builder: (context , snap) {
                      if(snap.hasData){
                        return Expanded(
                          flex: 90,
                          child: ListView.builder(
                            key: const PageStorageKey<String>(StoragePathKey.notificationPath),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  // Map arguments = {
                                  //   'postId': pr.notificationsModel!.data[index].activityId ?? "",
                                  //   'isLiked': false
                                  // };
                                  if(pr.notificationsModel!.data[index].type == AppNotificationType.FOLLOW){
                                    CustomToast(context: context, message: "Notification ${pr.notificationsModel!.data[index].type} found!",);
                                    Navigator.pushNamed(context, RouteName.thirdUserProfileView ,arguments: {'id' : pr.notificationsModel!.data[index].senderId});
                                  }
                                  else if(pr.notificationsModel!.data[index].type == AppNotificationType.LIKE){
                                    CustomToast(context: context, message: "Notification ${pr.notificationsModel!.data[index].type} found! ${{'postId': pr.notificationsModel!.data[index].activityId}}",);
                                    Navigator.pushNamed(context, RouteName.postDetailsView ,arguments: {'postId' : pr.notificationsModel!.data[index].activityId, 'isLiked' : true});
                                  }
                                  else if(pr.notificationsModel!.data[index].type == AppNotificationType.COMMENT){
                                    CustomToast(context: context, message: "Notification ${pr.notificationsModel!.data[index].type} found!",);
                                    Navigator.pushNamed(context, RouteName.postDetailsView ,arguments: {'postId' : pr.notificationsModel!.data[index].activityId, 'isLiked' : true});
                                  }
                                  else {
                                    CustomToast(context: context, message: "Notification type not found!",);
                                  }
                                },
                                onLongPress: () async {
                                 showDialog(context: context, builder: (context){
                                   return Dialog(child: AppDialog(
                                       dialogWidget:
                                       Center(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                           Text(AppStrings.deleteNotification, style: AppStyle.whiteBold16,),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                             TextButton(
                                               onPressed: () async {
                                                 Navigator.pop(context);
                                                await NotificationRepo().deleteNotification(notificationId: pr.notificationsModel!.data[index].id).then((value){

                                                });
                                             },
                                             child: Text(AppStrings.yes, style: AppStyle.whiteMedium16,)),
                                             TextButton(onPressed: () {
                                               Navigator.pop(context);
                                             }, child: Text(AppStrings.no, style: AppStyle.whiteMedium16,)),
                                           ],)
                                         ],),
                                       )),);
                                 });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    onTap: (){
                                      if(pr.notificationsModel!.data[index].type == AppNotificationType.FOLLOW){
                                        CustomToast(context: context, message: "Notification ${pr.notificationsModel!.data[index].type} found!",);
                                        Navigator.pushNamed(context, RouteName.thirdUserProfileView ,arguments: {'id' : pr.notificationsModel!.data[index].senderId});
                                      }
                                      else if(pr.notificationsModel!.data[index].type == AppNotificationType.LIKE){
                                        CustomToast(context: context, message: "Notification ${pr.notificationsModel!.data[index].type} found! ${{'postId': pr.notificationsModel!.data[index].activityId}}",);
                                        Navigator.pushNamed(context, RouteName.postDetailsView ,arguments: {'postId' : pr.notificationsModel!.data[index].activityId, 'isLiked' : true});
                                      }
                                      else if(pr.notificationsModel!.data[index].type == AppNotificationType.COMMENT){
                                        CustomToast(context: context, message: "Notification Type ${pr.notificationsModel!.data[index].type} found!",);
                                        Navigator.pushNamed(context, RouteName.postDetailsView ,arguments: {'postId' : pr.notificationsModel!.data[index].activityId, 'isLiked' : true});
                                      }
                                      else {
                                        CustomToast(context: context, message: "${ToastMsg.typeNotFound} ${pr.notificationsModel!.data[index].type}",);
                                      }
                                    },
                                    title: Text(pr.notificationsModel!.data[index].message.toString() ?? ""),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: UtilityHelper.image(pr.notificationsModel!.data[index].image, width: 60, height: 60, fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: pr.notificationsModel!.data.length ?? 10,
                          ),
                        );
                      }
                      else {
                        return const Expanded(
                          flex: 90,
                          child: LoadingWidgetTile(count: 5,),
                        );
                      }
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
