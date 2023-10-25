import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:whisper/model/search_user.dart';
import 'package:whisper/repository/search_repo/search_repo.dart';

class SearchUserViewModel extends ChangeNotifier
{

    onChanged(String? value) async {

    }

    final SearchRepository searchRepository = SearchRepository();
    Future searchUser({required String username}) async {
        await searchRepository.searchUser(SearchUserPayload(username: username)).then((value) {
            debugPrint("Response received in view model email is:${value!.data.email}");
            debugPrint("Response received in view model username is:${value!.data.username}");
        }).onError((error, stackTrace){
            debugPrint("Error in Search user View Model :$error");
        });
    }
}