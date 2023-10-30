import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/comment.dart';
import 'package:whisper/model/login_payload.dart';
import 'package:whisper/model/response.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/feed_response_model.dart';
import '../../model/like.dart';
import '../../model/post_model.dart';
import '../../utils/app_helper/app_url.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class PostRepository {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<ApiResponsePostCreatedModel?> createPost(PostPayload data) async {
    ApiResponsePostCreatedModel? res;
    await UserData.getUserAccessToken().then((accessToken) async {
      Map<String, String> resetHeader = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accessToken!,
      };
      await _baseAPIServices.postAPIWithHeader(AppUrl.createPostEndPoint, data.toJson(), resetHeader).then((value) {
        try {
          // debugPrint("$value is the API response");
          res = ApiResponsePostCreatedModel.fromJson(value);
        } catch (e){
          debugPrint("$e is the API error for pic upload");
        }
        return 200;
      }).onError((error, stackTrace) {
        debugPrint("Error in posting: $error");
        throw AppError(error.toString());
      });
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    // debugPrint("Returning ${res!.statusCode}");
    return res;
  }

  // Future<PostResponse?> getMyPost() async {
  //   PostResponse? response;
  //   UserData.getUserAccessToken().then((value) {
  //     _baseAPIServices.getAPI(AppUrl.getMyPostEndPoint, header).then((value) {
  //       debugPrint("Response of Get All Post");
  //       response = PostResponse.fromJson(value);
  //     }).onError((error, stackTrace) {
  //       debugPrint("Error Occurs");
  //     });
  //   }).onError((error, stackTrace) {});
  //   return response;
  // }

  Future<UserFeedModel?> getMyFeed() async {
    UserFeedModel? responses;
    Map<String, dynamic> res = {};
    await UserData.getUserAccessToken().then((value) async {
      header['Authorization'] = value!;
      await _baseAPIServices.getAPI(AppUrl.getMyFeedEndPoint, header).then((value) {
        // debugPrint(value.toString());
        responses = UserFeedModel.fromJson(value);
      }).onError((error, stackTrace) {
        throw AppError(error.toString());
      });
    }).onError((error, stackTrace) {
      throw AppError(error.toString());
    });
    // debugPrint("ReponseList length in repo is ${responses.length}");
    return responses;
  }

  Future<Map<String, dynamic>?> getListComments(String id) async {
    Map<String, dynamic>? response;
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.getAPI("${AppUrl.listCommentsEndPoint}?postId=$id", header).then((value) {
      response = value;
      // debugPrint(value.toString());
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    return response;
  }

  Future<ApiResponseLikesData?> getListLikes(String postId) async {
    ApiResponseLikesData? response;
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.getAPI("${AppUrl.getLikesEndPoint}$postId", header).then((value) {
      response = ApiResponseLikesData.fromJson(value);
      // debugPrint("Like list are:$value");
    }).onError((error, stackTrace){
      throw AppError(error.toString());
    });
    return response;
  }

  Future createComment(String postId, CommentPayload model) async {
    debugPrint("Going to comment on $postId");
    String? token = await UserData.getUserAccessToken();
    // header['Authorization'] = "Bearer "+token!;
    header['Authorization'] = token!;
    // debugPrint("$header is the header, model is ${model.toMap()}");
    await _baseAPIServices.postAPIWithHeader("https://harshitsocial.appskeeper.in/api/v1/user/createComment?postId=$postId", model.toMap(), header).then((value){
      // debugPrint("Comment Added! $value");
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
  }

  Future<String?> likePost(String postId) async {
    String? statusCode;
    String? token = await UserData.getUserAccessToken();
    // header['Authorization'] = "Bearer "+token!;
    header['Authorization'] = token!;
    // debugPrint("$header is the header, model is ${model.toMap()}");
    await _baseAPIServices.postAPIWithHeader("${AppUrl.postLikeEndPoint}$postId",
        {}, header).then((value){
      statusCode = value['statusCode'].toString();
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
    return statusCode;
  }

  Future<String?> dislikePost(String postId) async {
    String? statusCode;
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    // debugPrint("Id is $postId");
    await _baseAPIServices.deleteAPI("${AppUrl.postDislikeEndPoint}$postId",
        {}, header).then((value){
          // debugPrint("Post Disliked!");
      statusCode = value['statusCode'].toString();
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
    return statusCode;
  }

  Future<String?> reportPost(String postId) async {
    String? statusCode;
    debugPrint("Going to report on $postId");
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.postAPIWithHeader("https://harshitsocial.appskeeper.in/api/v1/user/reportPost?postId=$postId", {}, header).then((value){
      // debugPrint("Report on post :$postId status is $value");
      statusCode = value['statusCode'].toString();
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
    return statusCode;
  }

  Future<String?> editComment({required String postId, required String commendID, required String comment}) async {
    String? statusCode;
    // debugPrint("Going to edit on $postId");
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.patchAPI("https://harshitsocial.appskeeper.in/api/v1/user/editComment?postId=$postId&commentId=$commendID", {
      "comment": comment,
    }, header).then((value){
      // debugPrint("Edited on post :$postId comment $commendID status is $value");
      statusCode = value['statusCode'].toString();
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
    return statusCode;
  }

  Future<String?> deleteComment({required String postId, required String commentID,}) async {
    String? statusCode;
    // debugPrint("Going to delete on $postId");
    String? token = await UserData.getUserAccessToken();
    header['Authorization'] = token!;
    await _baseAPIServices.deleteAPI("https://harshitsocial.appskeeper.in/api/v1/user/deleteComment?postId=$postId&commentId=$commentID",{}, header).then((value){
      // debugPrint("deleted on post :$postId comment $commentID status is $value");
      statusCode = value['statusCode'].toString();
    }).onError((error, stackTrace){
      throw AppError("Error is:$error");
    });
    return statusCode;
  }

}
