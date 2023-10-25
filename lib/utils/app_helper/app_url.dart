class AppUrl
{
  static const baseUrl = 'https://harshitsocial.appskeeper.in/api/v1/user';
  static const signupCredEndPoint = "$baseUrl/signup";
  static const verifyUserSignup = "$baseUrl/verifyUser";
  static const loginEndPoint = '$baseUrl/login';
  static const logoutEndPoint = '$baseUrl/logout';
  static const forgetPasswordEmailEndPoint = '$baseUrl/forgot-password';
  static const verifyOTPForgetPasswordEmailEndPoint = '$baseUrl/verifyOTP';
  static const resetPasswordForgetPasswordEmailEndPoint = '$baseUrl/reset-password';
  static const resendOtpForgetPasswordEmailEndPoint = '$baseUrl/send-otp';
  static const signupOTPEndPoint = '$baseUrl/send-otp';
  static const createPostEndPoint = '$baseUrl/createPost';
  static const getMyPostEndPoint = '$baseUrl/getMyPost';
  static const getMyFeedEndPoint = '$baseUrl/userFeed';
  static const getMyProfileEndPoint = '$baseUrl/userProfile';
  static const listCommentsEndPoint = '$baseUrl/listComments';
  static const createCommentEndPoint = '$baseUrl/createComment?postId=';
  static const userSearchEndPoint = '$baseUrl/userSearch';
  static const getFollowersEndPoint = 'https://harshitsocial.appskeeper.in/api/v1/user/getFollowers?userId=';
  static const getFollowingEndPoint = '$baseUrl/getFollowing';
  static const unfollowUserEndPoint = '$baseUrl/unfollowUser';
  static const followUserEndPoint = '$baseUrl/followUser';
}