import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/app_rounded_button.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/view_model/add_post_view_model/add_post_view_model.dart';
import 'package:whisper/view_model/global_provider/get_profile_data_provider.dart';

import '../../utils/app_helper/app_strings.dart';

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
        ChangeNotifierProvider(
          create: (context) => AddPostViewModel(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            tooltip: "Go back",
            enableFeedback: true,
            icon: Icon(
              !Platform.isAndroid ? Icons.arrow_back_ios : Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedBox(hei: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      sizedBox(
                        wid: 10,
                      ),
                      SizedBox(
                          height: 45,
                          child: ClipOval(
                            child: UtilityHelper.image(dp),
                          )),
                      sizedBox(
                        wid: 10,
                      ),
                      Consumer<GetProfileData>(builder: (cont, pr, ch) {
                        return FutureBuilder(
                            future: pr.getUsername(),
                            builder:
                                (context, AsyncSnapshot<String?> asyncData) {
                              if (asyncData.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  width: 70,
                                  height: 20,
                                  color: AppColors.grey,
                                );
                              } else if (!asyncData.hasData ||
                                  asyncData.hasError) {
                                return const Text(AppStrings.error);
                              }
                              return Text("${asyncData.data}");
                            });
                      }),
                    ],
                  ),
                  Consumer<AddPostViewModel>(
                      builder: (context, provider, child) {
                    return Row(
                      children: [
                        AppRoundedButton(
                          onTap: () {
                            provider.uploadMyPost(context);
                          },
                          title: "Post",
                          width: 80,
                          buttonColor: Theme.of(context).primaryColorLight,
                        ),
                        sizedBox(
                          wid: 10,
                        ),
                      ],
                    );
                  }),
                ],
              ),
              sizedBox(
                hei: 10,
              ),
              Consumer<AddPostViewModel>(builder: (context, provider, ch) {
                return AppTextFormField(
                  onChanged: (value) {},
                  cont: provider.postContentCont,
                  focusNode: provider.postContentFocusNode,
                  obscureText: false,
                  maxLines: null,
                  isPrefixIconExist: false,
                  contentPadding: 10,
                  hintText: "What's in your mind?",
                );
              }),
              sizedBox(
                hei: 10,
              ),
              Consumer<AddPostViewModel>(builder: (context, provider, child) {
                if (!provider.isPicked) {
                  return sizedBox();
                }
                return Stack(
                  children: [
                    AspectRatio(aspectRatio: 1,
                    child: Image.file(provider.pickedImage!, fit: BoxFit.fill,)),
                    if(provider.isPicked) Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.black, width: 1.0),
                        color: AppColors.white,
                      ),
                      child: IconButton(tooltip:"Remove", padding: EdgeInsets.zero, alignment: Alignment.center, onPressed: (){
                        provider.isPicked = false;
                        provider.pickedImage = null;
                        provider.notifyListeners();
                      }, icon: const Icon(FontAwesomeIcons.xmark, color: AppColors.black,size: 20,))),
                    )
                  ],
                );
              }),
              sizedBox(
                hei: 10,
              ),
              Consumer<AddPostViewModel>(builder: (context, provider, ch) {
                return Row(
                  children: [
                    sizedBox(
                      wid: 10,
                    ),
                    IconButton(
                      onPressed: () async {
                        provider.fetchFromGallery();
                        debugPrint(
                            "Source Gallery Clicked ${provider.postContentCont.text.toString().trim().length}");
                      },
                      icon: const Icon(FontAwesomeIcons.images),
                      color: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                      onPressed: () async {
                        provider.fetchFromCamera();
                        ("Source Camera Clicked");
                      },
                      icon: const Icon(FontAwesomeIcons.cameraRetro),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
