import 'package:flutter/material.dart';

import '../../../utils/app_helper/app_keys.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        key: const PageStorageKey<String>(StoragePathKey.friendsListPath),
        itemBuilder: (BuildContext context, int index)
        {
          return ListTile(
            title: Text("Friend $index"),
          );
        },
        itemCount: 100,),
    );
  }
}
