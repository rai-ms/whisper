import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/res/components/custom_toast.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/view_model/edit_profile_view_model/edit_profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EditProfileViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            ),
          ),
          actions: [
            Consumer<EditProfileViewModel>(
              builder: (context, pr, child) {
                return TextButton(
                    onPressed: () {
                      pr.ediProfile().then((value) {
                        CustomToast(
                            context: context,
                            message: AppStrings.profileUpdated);
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      AppStrings.save,
                      style: AppStyle.whiteMedium16,
                    ));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<EditProfileViewModel>(
                builder: (context, provider, ch) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sizedBox(hei: 20),
                      InkWell(
                        onTap: () {
                          provider.fetchFromGallery();
                        },
                        child: (provider.isPicked)
                            ? SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    provider.pickedImage!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                      ),
                      sizedBox(hei: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(flex: 2, child: Text("Username")),
                          sizedBox(wid: 10),
                          Expanded(
                            flex: 6,
                            child: AppTextFormField(
                              obscureText: false,
                              cont: provider.usernameController,
                              isPrefixIconExist: false,
                              contentPadding: 10,
                            ),
                          ),
                        ],
                      ),
                      sizedBox(hei: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(flex: 2, child: Text("Full Name")),
                          sizedBox(wid: 10),
                          Expanded(
                            flex: 6,
                            child: AppTextFormField(
                              obscureText: false,
                              cont: provider.fullNameController,
                              isPrefixIconExist: false,
                              contentPadding: 10,
                            ),
                          ),
                        ],
                      ),
                      sizedBox(hei: 10),
                      Row(
                        children: [
                          const Expanded(flex: 2, child: Text("Bio")),
                          sizedBox(wid: 10),
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: provider.bioController,
                              maxLines: null,
                              onFieldSubmitted: (value) {
                                // Utils.changeFocus(context, currentFocus, nextFocus);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.black),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      sizedBox(hei: 20),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
