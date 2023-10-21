class AppConstants {
//Api constants
  final int statusCode201 = 201;
  final int statusCode200 = 200;
  static const login = 'login Successfully';
  static const logout = 'logout Successfully';

// App constatnts
  static RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,50}$');
  static final RegExp email =
      RegExp(r'^\w+(?:[.-]?\w+)*@\w+(?:[.-]?\w+)*(?:\.\w{2,3})+$');
  static RegExp webSite = RegExp(
      r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?',
      caseSensitive: false);

// for checking null value
  bool checkStatusCode(status) {
    if (status == statusCode201 || status == statusCode200) {
      return true;
    } else {
      return false;
    }
  }
}

class AppRegex {
  /// email validation pattern
  static const String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// password validation pattern
  static const String passwordRegex =
      r'^((?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,15}$)';

  /// name validation pattern
  static const String nameRegex =
      r"^\s*([A-Za-z]{1,}([\.,] |[-']|| ))+[A-Za-z]+\.?\s*$";

  /// mobile validation pattern
  static const String mobileRegex = r'(^(?:[+0]9)?[0-9]{9,11}$)';

  // URL validation pattern
  static const String urlRegex =
      r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?';

  // Website URL validation pattern
  static const String websiteUrlRegex =
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
}

class AnalyticsEvents {
  static const String appLaunch = 'app_launch';
  static const String googleSignIn = 'google_signin';
  static const String facebookSignIn = 'facebook_signin';
  static const String appleSignIn = 'apple_signin';
  static const String firstTimeSignUp = 'first_time_user_signup';
  static const String signIn = 'user_signin';
  static const String verifyOtp = 'verify_otp';
  static const String invalidOtp = 'invalid_otp';
  static const String resendOtp = 'resend_otp';
  static const String viewPreview = 'view_preview';
  static const String saveProfile = 'save_profile';
  static const String saveBusinessProfile = 'save_business_profile';
  static const String addLinks = 'add_links';
  static const String rearrangeIcons = 'rearrange_icons';
  static const String iconStateOnOff = 'icon_state_on/off';
  static const String connectionViewed = 'connection_viewed';
  static const String connectionDeleted = 'connection_deleted';
  static const String previewCodeScanned = 'preview_code_scanned';
  static const String previewUrl = 'preview_url';
  static const String previewAccessoryTap = 'preview_accessory tap';
  static const String scanBusinessCard = 'scan_business_card';
  static const String copyLink = 'copy_link';
  static const String shareViaEmail = 'share_via_email';
  static const String shareViaMessage = 'share_via_message';
  static const String shareViaNative = 'share_via_native';
  static const String customQr = 'custom_qr';
  static const String saveCustomQr = 'save_custom_qr';
  static const String NFCActivated = 'accessory_activated';
  static const String getDevice = 'get_device';
  static const String deleteAccount = 'delete_account';
  static const String deactivateAccount = 'deactivate_account';
  static const String signOut = 'sign_out';
  static const String howToTap = 'how_to_tap';
  static const String updateProfileLink = 'update_profile_link';
}
