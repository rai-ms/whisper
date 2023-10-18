import 'package:flutter/cupertino.dart';

class PhotosList extends StatefulWidget {
  const PhotosList({super.key});

  @override
  State<PhotosList> createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey<String>('photosListPath'),
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
}
