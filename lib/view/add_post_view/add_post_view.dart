import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/view_model/add_post_view_model/add_post_view_model.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AddPostViewModel(),
          ),
        ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            tooltip: "Go back",
            enableFeedback: true,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
          ),
        ),
        body: const Center(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
