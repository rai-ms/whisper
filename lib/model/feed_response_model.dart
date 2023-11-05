// /// It is the response class of API returns on the PostViewPage which shows the post where the base is [FeedApiResponse]
// /// It contains the [statusCode] pf type int, api response [type] of type [String] and [List] of [UserFeed] data, returns from api
// class FeedApiResponse {
//   final int statusCode;
//   final String type;
//   final List<UserFeed> userFeed;
//
//   FeedApiResponse({
//     required this.statusCode,
//     required this.type,
//     required this.userFeed,
//   });
//
//   factory FeedApiResponse.fromJson(Map<String, dynamic> json) {
//     final List<dynamic> userFeedList = json['User_Feed'];
//     final List<UserFeed> userFeed = userFeedList
//         .map((feedJson) => UserFeed.fromJson(feedJson))
//         .toList();
//
//     return FeedApiResponse(
//       statusCode: json['statusCode'],
//       type: json['type'],
//       userFeed: userFeed,
//     );
//   }
// }
//
//
//
// /// It is the response class of API returns on the PostViewPage which shows the post where the base is [FeedApiResponse]
// /// It contains 2 fields i.e. [FeedUserData], [FeedUserPost]
//
// class UserFeed {
//   final FeedUserData userData;
//   final List<FeedUserPost> userPosts;
//
//   UserFeed({
//     required this.userData,
//     required this.userPosts,
//   });
//
//   factory UserFeed.fromJson(Map<String, dynamic> json) {
//     final List<dynamic> userPostsList = json['UserPosts'];
//     final List<FeedUserPost> userPosts = userPostsList
//         .map((postJson) => FeedUserPost.fromJson(postJson))
//         .toList();
//
//     return UserFeed(
//       userData: FeedUserData.fromJson(json['UserData']),
//       userPosts: userPosts,
//     );
//   }
// }
//
//
//
// /// It is the response class of API returns on the PostViewPage which shows the post where the base is [FeedApiResponse]
// /// It contains the [id], [username], [email] of the user who posted the post,
// class FeedUserData {
//   final String id;
//   final String username;
//   final String email;
//
//   FeedUserData({
//   required this.id,
//   required this.username,
//   required this.email,
// });
//
// factory FeedUserData.fromJson(Map<String, dynamic> json) {
//   return FeedUserData(
//     id: json['_id'],
//     username: json['username'],
//     email: json['email'],
//     );
//   }
// }
//
//
//
// /// It is the response class of API returns on the PostViewPage which shows the post where the base is [FeedApiResponse]
// /// It contained the [id] of the post,
// /// [userId] of the user who is posted,
// /// post image [url],
// /// [mediaType] (photo/image),
// /// [caption] i.e. description of the post
// /// [likeCount] i.e. total likes on the post
// /// [commentCount] i.e. total comment on the post
// /// [isLiked] i.e. weather the current user/me is liked on the current post
// class FeedUserPost {
//   final String id;
//   final String userId;
//   final String url;
//   final String mediaType;
//   final String caption;
//   final int likeCount;
//   final int commentCount;
//   final bool isLiked;
//
//   FeedUserPost({
//   required this.id,
//   required this.userId,
//   required this.url,
//   required this.mediaType,
//   required this.caption,
//   required this.likeCount,
//   required this.commentCount,
//   required this.isLiked,
// });
//
// factory FeedUserPost.fromJson(Map<String, dynamic> json) {
//   return FeedUserPost(
//       id: json['_id'],
//       userId: json['userId'],
//       url: json['url'],
//       mediaType: json['mediaType'],
//       caption: json['caption'],
//       likeCount: json['likeCount'],
//       commentCount: json['commentCount'],
//       isLiked: json['isLiked'],
//     );
//   }
// }

class UserFeedModel {
  final int statusCode;
  final String? type;
  List<UserFeedItem> userFeed;

  UserFeedModel({
    required this.statusCode,
    required this.type,
    required this.userFeed,
  });

  factory UserFeedModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? userFeedList = json['User_Feed'];
    final List<UserFeedItem> userFeed = userFeedList?.map((item) {
          return UserFeedItem.fromJson(item);
        }).toList() ??
        [];

    return UserFeedModel(
      statusCode: json['statusCode'],
      type: json['type'],
      userFeed: userFeed,
    );
  }
}

class UserFeedItem {
  final UserDatas userData;
  UserPosts userPosts;

  UserFeedItem({
    required this.userData,
    required this.userPosts,
  });

  factory UserFeedItem.fromJson(Map<String, dynamic> json) {
    return UserFeedItem(
      userData: UserDatas.fromJson(json['UserData']),
      userPosts: UserPosts.fromJson(json['UserPosts']),
    );
  }
}

class UserDatas {
  final String? id;
  final String? username;
  final String? email;
  final String? profilePic;
  final String? fullName;

  UserDatas({
    required this.id,
    required this.username,
    required this.email,
    this.profilePic,
    this.fullName,
  });

  factory UserDatas.fromJson(Map<String, dynamic> json) {
    return UserDatas(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilePic'],
      fullName: json['fullName'],
    );
  }
}

class UserPosts {
  final String? id;
  final String? userId;
  final String? url;
  final String? mediaType;
  final String? caption;
  int likeCount;
  final int commentCount;
  final String? createdAt;
  bool isLiked;
  final String? content;

  UserPosts({
    required this.id,
    required this.userId,
    required this.url,
    required this.mediaType,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.isLiked,
    this.content,
  });

  factory UserPosts.fromJson(Map<String, dynamic> json) {
    return UserPosts(
      id: json['_id'],
      userId: json['userId'],
      url: json['url'],
      mediaType: json['mediaType'],
      caption: json['caption'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: json['createdAt'],
      isLiked: json['isLiked'],
      content: json['content'],
    );
  }
}
