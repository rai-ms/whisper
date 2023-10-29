import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/components/app_text_form_field.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
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
        ChangeNotifierProvider(create: (context)=> EditProfileViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<EditProfileViewModel>(
            builder: (context, provider, ch) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      sizedBox(hei: 20),
                      const CircleAvatar(
                        radius: 100,
                        backgroundColor: AppColors.grey,
                      ),
                      sizedBox(hei: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text("Username")),
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
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text("Bio")),
                          sizedBox(wid: 10),
                          Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: provider.bioController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColors.black),),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all( Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColors.black),),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColors.black),),
                                ),
                              ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              );
            }
          ),
      ),
        ),
    ),);
  }
}
