import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/routes/route_name.dart';
import 'package:whisper/view_model/search_user/search_user_view_model.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchUserViewModel())
      ],
      child: Consumer<SearchUserViewModel>(builder: (context, pr1, ch) {
        return Column(
          children: [
            sizedBox(hei: 20),
            AppTextFormField(
              cont: pr1.controller,
              onChanged: pr1.onChanged,
              style: AppStyle.primaryColorDarkMedium20(context),
              obscureText: false,
              hintText: "Find your friend",
              labelText: "Search",
            ),
            sizedBox(hei: 20),
            Expanded(
              child: FutureBuilder(
                future: pr1.onChanged(pr1.controller.text.toString().trim()),
                builder: (context, snapshot) {
                  if (pr1.searchResponseUserData != null) {
                    return ListView.builder(
                      itemCount: pr1.searchResponseUserData!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.thirdUserProfileView,
                                arguments: {
                                  'id':
                                      pr1.searchResponseUserData!.data[index].id
                                });
                            // pr1.controller.dispose();
                          },
                          child: SizedBox(
                            width: 300,
                            child: ListTile(
                              leading: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ClipOval(
                                      child: UtilityHelper.image(
                                          pr1.searchResponseUserData!
                                                  .data[index].profilePic ??
                                              dp,
                                          fit: BoxFit.fill))),
                              title: Text(pr1.searchResponseUserData!
                                  .data[index].username),
                              // subtitle: Text(pr1.searchResponseUserData!.data[index].email.toString())
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // if(snapshot.connectionState == ConnectionState.waiting){
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  else if (pr1.searchResponseUserData == null) {
                    return const Text("---Search User---");
                  } else {
                    return const Text("Data Fetch with error");
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
