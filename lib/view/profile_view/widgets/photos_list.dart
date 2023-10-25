import 'package:flutter/cupertino.dart';

import '../../../utils/app_helper/app_keys.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
      key: const PageStorageKey<String>(StoragePathKey.photosListPath),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0, // Add spacing as needed.
        mainAxisSpacing: 2.0,  // Add spacing as needed.
      ),
      itemCount: 22,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: const Color.fromARGB(156, 204, 199, 199),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
