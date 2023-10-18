import 'package:flutter/cupertino.dart';
import 'package:whisper/utils/app_helper/app_color.dart';

class PersonalPost extends StatefulWidget {
  const PersonalPost({super.key});

  @override
  State<PersonalPost> createState() => _PersonalPostState();
}

class _PersonalPostState extends State<PersonalPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      color: AppColors.black,
    );
  }
}
