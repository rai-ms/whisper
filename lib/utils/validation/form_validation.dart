import '../app_helper/app_constants.dart';
import '../app_helper/app_integer.dart';
import '../app_helper/app_strings.dart';

class FormValidation {
  // We can give only alphabet
  static String? validateName(String? val) {
    var _value = val ?? '';
    final _nameRegExp = RegExp(AppRegex.nameRegex);
    if (_value.isEmpty) {
      return AppStrings.requiredText;
    } else if (!_nameRegExp.hasMatch(_value)) {
      return AppStrings.invalidName;
    }
    return null;
  }

  /// ------------------ Check Value is Empty ------------------

  static String? isEmpty(String? text) {
    if (text!.isEmpty) {
      return AppStrings.requiredText;
    }
    return null;
  }

  /// ------------------ Mobile Number  Validation ------------------

  static String? mobileNoValidation(String? number) {
    if (number?.isEmpty ?? false) {
      return AppStrings.enterMobileNumber;
    }
    if (number!.isNotEmpty) {
      if (number.length < AppIntegers.minPhoneNumberLength) {
        return AppStrings.invalidMobileNumber;
      } else if (!RegExp(AppRegex.mobileRegex).hasMatch(number.trim())) {
        return AppStrings.invalidMobileNumber;
      }
    }
    return null;
  }

  /// ------------------ Email Validation ------------------

  static String? emailValidation(String? email) {
    if (email!.trim().isEmpty) {
      return AppStrings.provideEmilId;
    }
    /*else if (email.trim().length < AppIntegers.minEmailLength) {
      return AppStrings.emailLength;
    } */
    else if (!RegExp(AppRegex.emailRegex).hasMatch(email.trim())) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  // We have validate a lot of things in password
  //(like - length between 8-15, minimum one capital and one small letter, minimum one special character)
  static String? validatePassword(String? val) {
    var _value = val ?? '';
    final _passwordRegExp = RegExp(AppRegex.passwordRegex);
    if (_value.isEmpty) {
      return AppStrings.requiredText;
    } else if (!_passwordRegExp.hasMatch(_value)) {
      return AppStrings.passwordMustContain;
    }
    return null;
  }

  /// ------------------ URL Validation ------------------

  static String? urlValidation(String? url) {
    if (url!.trim().isEmpty) {
      return AppStrings.provideURL;
    } else if (!Uri.parse(url).isAbsolute) {
      return AppStrings.invalidURL;
    }
    return null;
  }

  /// ------------------Website Validation ------------------

  static String? websiteValidation(String? website) {
    if (website!.trim().isEmpty) {
      return AppStrings.provideWebsite;
    } else if (!RegExp(AppRegex.websiteUrlRegex).hasMatch(website.trim())) {
      return AppStrings.invalidWebsite;
    }
    return null;
  }
}
