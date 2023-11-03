import 'package:flutter/material.dart';
import '../utils/app_helper/app_color.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      this.cont,
      this.isPrefixIconExist = true,
      this.focusNode,
      this.onFieldSubmitted,
      this.validator,
      this.maxLines = 1,
      this.hintText,
      this.label,
      this.onChanged,
      this.enableBorderColor,
      this.disableBorderColor,
      this.textInputType,
      this.contentPadding,
      this.obscureText = true,
      this.style,
      this.prefixIcon,
      this.hintStyle,
      this.isCollapsed = false,
      this.enable,
      this.labelText,
      this.suffixIcon});
  final TextEditingController? cont;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;
  final String? hintText;
  final Widget? label;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final bool isCollapsed;
  final bool isPrefixIconExist;
  final bool? enable;
  final double? contentPadding;
  final Color? disableBorderColor, enableBorderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscureText,
      style: style,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      controller: cont,
      maxLines: maxLines,
      enabled: enable,
      focusNode: focusNode,
      validator: validator ??
          (_) {
            return null;
          },
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: contentPadding == null
            ? EdgeInsets.zero
            : EdgeInsets.all(contentPadding!),
        labelText: labelText,
        hintStyle: hintStyle,
        isCollapsed: isCollapsed,
        hintText: hintText,
        label: label,
        prefixIcon: !isPrefixIconExist
            ? null
            : prefixIcon ??
                const Icon(
                  Icons.person,
                  color: AppColors.blueSplashScreen,
                ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide:
              BorderSide(width: 2, color: enableBorderColor ?? AppColors.black),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
              width: 2, color: disableBorderColor ?? AppColors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide:
              BorderSide(width: 2, color: enableBorderColor ?? AppColors.black),
        ),
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        hoverColor: AppColors.blueAccent,
      ),
    );
  }
}
