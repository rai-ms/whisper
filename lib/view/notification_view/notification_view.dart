import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/loading_tile.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/notification_view_model/notification_view_model.dart';
import '../../components/utility_helper.dart';
import '../../model/notification_model.dart';
import '../../utils/app_helper/app_keys.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
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
                  return Column(
                    children: [
                      if(pr.notificationsModel != null) Expanded(
                      flex: 90,
                      child: ListView.builder(
                        key: const PageStorageKey<String>(
                            StoragePathKey.notificationPath),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ListTile(
                              onTap: (){
                                Map arguments = {
                                  'postId': pr.notificationsModel!.data[index].activityId ?? "",
                                  'isLiked': false
                                };
                                Navigator.pushNamed(context, RouteName.postDetailsView, arguments: arguments);
                              },
                              title: Text(pr.notificationsModel!.data[index].message.toString() ?? ""),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: UtilityHelper.image(pr.notificationsModel!.data[index].image)),
                            ),
                          );
                        },
                        itemCount: pr.notificationsModel!.data.length ?? 10,
                      ),
                    ),
                      if(pr.notificationsModel == null) Expanded(
                          flex: 90,
                          child: LoadingWidgetTile(count: 5,),
                        )

                    ],
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
