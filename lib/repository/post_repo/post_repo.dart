import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/model/login_payload.dart';
import 'package:whisper/utils/app_helper/app_keys.dart';
import 'package:whisper/utils/app_helper/app_strings.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/feed_response_model.dart';
import '../../model/like.dart';
import '../../model/post_api_res.dart';
import '../../model/post_model.dart';
import '../../utils/app_helper/app_enum.dart';
import '../../utils/app_helper/app_url.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';
import '../notification_repo/notification_repo.dart';

class PostRepository {
  final BaseApiServices _baseAPIServices = NetworkApiServices();
  final NotificationRepo notifications = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.contentType: ApiKeys.applicationJson,
  };

  Future<ApiResponsePostCreatedModel?> createPost(PostPayload data) async {
    ApiResponsePostCreatedModel? res;
    await UserData.getUserAccessToken().then((accessToken) async {
      Map<String, String> resetHeader = {
        ApiKeys.contentType: ApiKeys.applicationJson,
        ApiKeys.authorization: accessToken!,
      };
      // debugPrint("Header is $resetHeader");
      await _baseAPIServices
          .postAPIWithHeader(
              AppUrl.createPostEndPoint, data.toJson(), resetHeader)
          .then((value) {
        try {
          // debugPrint("$value is the API response");
          res = ApiResponsePostCreatedModel.fromJson(value);
        } catch (e) {
          // debugPrint("$e error in data conversion");
        }
        return 200;
      }).onError((error, stackTrace) {
        // debugPrint("Error in posting: $error");
        throw AppError(error.toString());
      });
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    // debugPrint("Returning ${res!.statusCode}");
    return res;
  }

  Future<UserFeedModel?> getMyFeed( {required int pageNo, required int limit}) async {
    UserFeedModel? responses;
    await UserData.getUserAccessToken().then((value) async {
      header[ApiKeys.authorization] = value!;
      debugPrint(header.toString());
      await _baseAPIServices
          .getAPI(
              "${AppUrl.getMyFeedEndPoint}?pageNo=$pageNo&limit=$limit", header)
          .then((value) {
        // debugPrint(value.toString());
        responses = UserFeedModel.fromJson(value);
      }).onError((error, stackTrace) {
        throw AppError(error.toString());
      });
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return responses;
  }

  Future<Map<String, dynamic>?> getListComments(String id) async {
    Map<String, dynamic>? response;
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    // debugPrint("$id");
    await _baseAPIServices
        .getAPI("${AppUrl.listCommentsEndPoint}?postId=$id", header)
        .then((value) {
      response = value;
      // debugPrint(value.toString());
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return response;
  }

  Future<ApiResponseLikesData?> getListLikes(String postId) async {
    ApiResponseLikesData? response;
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices
        .getAPI("${AppUrl.getLikesEndPoint}$postId", header)
        .then((value) {
      response = ApiResponseLikesData.fromJson(value);
      // debugPrint("Like list are:$value");
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return response;
  }

  Future<ApiResponsePostModel?> getPostDetails(String postId) async {
    ApiResponsePostModel? response;
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices
        .getAPI("${AppUrl.postDetailsEndPoint}$postId", header)
        .then((value) {
      response = ApiResponsePostModel.fromJson(value);
      // debugPrint("getPostDetails are:$value");
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    return response;
  }

  Future<String?> createComment(String postId, CommentPayload model, String postedById) async {
    // debugPrint("Going to comment on $postId");
    String? res;
    String? token = await UserData.getUserAccessToken();
    String? myId = await UserData.getUserId();
    // header['Authorization'] = "Bearer "+token!;
    header[ApiKeys.authorization] = token!;
    debugPrint("$header is the header, model is ${model.toMap()}");
    await _baseAPIServices.postAPIWithHeader("https://harshitsocial.appskeeper.in/api/v1/user/createComment?postId=$postId", model.toMap(), header).then((value) {
      debugPrint("Comment Added! $value");
      res = value.toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    await NotificationRepo().addPushNotification(postedById, postId!, AppNotificationType.COMMENT);
    return res;
  }

  Future<String?> likePost(String postId, String postedById) async {
    String? statusCode;
    String? token = await UserData.getUserAccessToken();
    String? myId = await UserData.getUserId();
    // header['Authorization'] = "Bearer "+token!;
    header[ApiKeys.authorization] = token!;
    // debugPrint("$header is the header, model is ${model.toMap()}");
    await _baseAPIServices
        .postAPIWithHeader("${AppUrl.postLikeEndPoint}$postId", {}, header)
        .then((value) {
      debugPrint(value.toString());
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    await NotificationRepo().addPushNotification(postedById, postId!, AppNotificationType.LIKE);
    return statusCode;
  }

  Future<String?> dislikePost(String postId) async {
    String? statusCode;
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    // debugPrint("Id is $postId");
    await _baseAPIServices
        .deleteAPI("${AppUrl.postDislikeEndPoint}$postId", {}, header)
        .then((value) {
      // debugPrint("Post Disliked!");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    return statusCode;
  }

  Future<String?> reportPost(String postId) async {
    String? statusCode;
    debugPrint("Going to report on $postId");
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices.postAPIWithHeader("https://harshitsocial.appskeeper.in/api/v1/user/reportPost?postId=$postId", {}, header).then((value) {
      // debugPrint("Report on post :$postId status is $value");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    return statusCode;
  }

  Future<String?> editComment({required String postId, required String commendID, required String comment}) async {
    String? statusCode;
    // debugPrint("Going to edit on $postId");
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices.patchAPI("${AppUrl.editCommentEndPoint}?postId=$postId&commentId=$commendID", {"comment": comment,}, header).then((value) {
      // debugPrint("Edited on post :$postId comment $commendID status is $value");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    return statusCode;
  }

  Future<String?> deleteComment({required String postId, required String commentID,}) async {
    String? statusCode;
    // debugPrint("Going to delete on $postId");
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices
        .deleteAPI(
            "https://harshitsocial.appskeeper.in/api/v1/user/deleteComment?postId=$postId&commentId=$commentID",
            {},
            header)
        .then((value) {
      // debugPrint("deleted on post :$postId comment $commentID status is $value");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    return statusCode;
  }

  Future<String?> deletePost(String postId) async {
    String? statusCode;
    String? token = await UserData.getUserAccessToken();
    header[ApiKeys.authorization] = token!;
    await _baseAPIServices.deleteAPI("${AppUrl.deletePostEndPoint}$postId", {}, header).then((value) {
      debugPrint("Post Deleted!");
      statusCode = value[ApiKeys.statusCode].toString();
    }).onError((error, stackTrace) {
      throw AppError("${AppStrings.error} is:$error");
    });
    return statusCode;
  }
}
