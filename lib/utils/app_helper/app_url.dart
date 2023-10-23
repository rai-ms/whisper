class AppUrl
{
  static const baseUrl = 'https://harshitsocial.appskeeper.in/api/v1/user';
  static const signupCredEndPoint = "$baseUrl/signup";
  static const verifyUserSignup = "$baseUrl/verifyUser";
  static const loginEndPoint = '$baseUrl/login';
  static const forgetPasswordEmailEndPoint = '$baseUrl/forgot-password';
  static const verifyOTPForgetPasswordEmailEndPoint = '$baseUrl/verifyOTP';
  static const resetPasswordForgetPasswordEmailEndPoint = '$baseUrl/reset-password';
  static const resendOtpForgetPasswordEmailEndPoint = '$baseUrl/send-otp';
  static const signupOTPEndPoint = '$baseUrl/send-otp';
  static const createPostEndPoint = '$baseUrl/createPost';
  static const getMyPostEndPoint = '$baseUrl/getMyPost';
  static const getMyFeedEndPoint = '$baseUrl/userFeed';
}