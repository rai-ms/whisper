import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/view_model/global_provider/global_provider.dart';
import 'package:whisper/view_model/search_user/search_user_view_model.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppGlobalProvider>(
      builder: (context, pr1, ch) {
        return FutureBuilder(
          future: AppGlobalProvider.onChanged(AppGlobalProvider.controller.text.toString().trim()),
          builder: (context, snapshot){
            if(AppGlobalProvider.searchResponseUserData != null){
              pr1.notifyListeners();
              return ListTile(
                leading: UtilityHelper.image(dp),
                title: Text(AppGlobalProvider.searchResponseUserData!.data.username.toString()),
                subtitle: Text(AppGlobalProvider.searchResponseUserData!.data.email.toString()),
              );
            }
          if(!snapshot.hasData){
            pr1.notifyListeners();
            return const Text("Data Fetch");
          }
          else if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            pr1.notifyListeners();
            return const Center(child: CircularProgressIndicator());
          }
          else {
            return const Text("Data Fetch with error");
          }
        },);
      }
    );
  }
}
