import 'package:flutter/cupertino.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Search User"));
  }
}
