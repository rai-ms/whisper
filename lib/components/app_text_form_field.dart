import 'package:flutter/material.dart';
import '../utils/app_helper/app_color.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({super.key, this.cont, this.focusNode, this.onFieldSubmitted, this.validator, this.hintText, this.label, this.onChanged, this.textInputType, this.obscureText = true, this.style, this.prefixIcon, this.hintStyle, this.isCollapsed = false, this.labelText, this.suffixIcon});
  final TextEditingController? cont;
  final FocusNode? focusNode;
  final String? Function (String?)? validator;
  final String? Function (String?)? onFieldSubmitted;
  final String? hintText;
  final Widget? label;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final bool isCollapsed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscureText,
      style: style,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      controller: cont,
      focusNode: focusNode,
      validator: validator ?? (_){ return null;},
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.zero,
        labelText: labelText,
        hintStyle: hintStyle,
        isCollapsed:isCollapsed ,
        prefixIcon: prefixIcon?? const Icon(Icons.person,color: AppColors.blueSplashScreen,),
        border: const OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(width: 2, color: AppColors.black)),
        hintText: hintText,
        label:label,
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        hoverColor: AppColors.blueAccent),
    );
  }
}
