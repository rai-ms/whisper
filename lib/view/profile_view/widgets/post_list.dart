import 'package:flutter/cupertino.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey<String>('postListPath'),
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
    ) ;
  }
}
