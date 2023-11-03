class AppUrl {
  static const baseUrl = 'https://harshitsocial.appskeeper.in/api/v1/user';
  static const signupCredEndPoint = "$baseUrl/signup";
  static const verifyUserSignup = "$baseUrl/verifyUser";
  static const loginEndPoint = '$baseUrl/login';
  static const logoutEndPoint = '$baseUrl/logout';
  static const forgetPasswordEmailEndPoint = '$baseUrl/forgot-password';
  static const verifyOTPForgetPasswordEmailEndPoint = '$baseUrl/verifyOTP';
  static const resetPasswordForgetPasswordEmailEndPoint =
      '$baseUrl/reset-password';
  static const resendOtpForgetPasswordEmailEndPoint = '$baseUrl/send-otp';
  static const signupOTPEndPoint = '$baseUrl/send-otp';
  static const createPostEndPoint = '$baseUrl/createPost';
  static const getMyPostEndPoint = '$baseUrl/getMyPost';
  static const getMyFeedEndPoint = '$baseUrl/userFeed';
  static const deletePostEndPoint = '$baseUrl/deletePost?postId=';
  static const getMyProfileEndPoint = '$baseUrl/userProfile';
  static const listCommentsEndPoint = '$baseUrl/listComments';
  static const getLikesEndPoint = '$baseUrl/getPostLikes?postId=';
  static const postDetailsEndPoint = '$baseUrl/post?postId=';
  static const createCommentEndPoint = '$baseUrl/createComment?postId=';
  static const userSearchEndPoint = '$baseUrl/userSearch?name=';
  static const getFollowersEndPoint = '$baseUrl/getFollowers?userId=';
  static const getFollowingEndPoint = '$baseUrl/getFollowing';
  static const unfollowUserEndPoint = '$baseUrl/unfollowUser?followingId=';
  static const followUserEndPoint = '$baseUrl/followUser?followingId=';
  static const postDislikeEndPoint = '$baseUrl/postDislike?postId=';
  static const postLikeEndPoint = '$baseUrl/postLike?postId=';
  static const editProfileEndPoint = '$baseUrl/editProfile';
  static const editCommentEndPoint = '$baseUrl/editComment';
}
