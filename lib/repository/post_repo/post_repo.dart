import 'package:flutter/cupertino.dart';
import 'package:whisper/data/app_exceptions/app_exception.dart';
import 'package:whisper/model/payloads.dart';
import 'package:whisper/model/response.dart';
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/feed_response_model.dart';
import '../../utils/app_helper/app_url.dart';
import '../../utils/app_helper/user_data_preferences/user_data.dart';

class PostRepository {

  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    "Authorization" : "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    "Content-Type":"application/json; charset=UTF-8",
  };

  Future<UploadPostResponse?> createPost(PostPayload data) async {
    UploadPostResponse? res;
    await UserData.getUserAccessToken().then((accessToken) async {
      Map<String, String> resetHeader = {'Content-Type':'application/json; charset=UTF-8', 'Authorization': accessToken!,};
      await _baseAPIServices.postAPIWithHeader(AppUrl.createPostEndPoint, data.toJson(), resetHeader).then((value)
      {
        debugPrint(value['type']);
        try{
          res = UploadPostResponse.fromJson(value);
          debugPrint("$value is the api response ${res!.type}");
        } catch(e) {
          debugPrint("Error in conversion");
        }
      }).onError((error, stackTrace){debugPrint("Error in posting: $error"); throw AppError(error.toString());});
    }).onError((error, stackTrace){debugPrint("UserId fetch error $error");});
    debugPrint("Returning ${res!.statusCode}");
    return res;
  }
  
  Future<PostResponse?> getMyPost() async {
    PostResponse? response;
     UserData.getUserAccessToken().then((value){
       _baseAPIServices.getAPI(AppUrl.getMyPostEndPoint, header).then((value){
         debugPrint("Response of Get All Post");
         response = PostResponse.fromJson(value);
       }).onError((error, stackTrace){
         debugPrint("Error Occurs");
       });
     }).onError((error, stackTrace){});
    return response;
  }

  Future<List<FeedApiResponse>?> getMyFeed() async {
    List<FeedApiResponse>? responses = [];
    Map<String, dynamic> res = {};
    await UserData.getUserAccessToken().then((value) async {
       header['Authorization'] = value!;
       await _baseAPIServices.getAPI(AppUrl.getMyFeedEndPoint, header).then((value){
         res = value;
         res.remove("statusCode");
         res.remove("type");
         res.forEach((key, values) {
           var user = FeedUserData.fromJson(values['UserData']);
           var post = FeedUserPost.fromJson(values['UserPosts']);
           responses.add(FeedApiResponse(feedUserData: user, feedUserPost:post));
           debugPrint("Code Called for $key");
         });
       }).onError((error, stackTrace){
         debugPrint("Error Occurs $error");
       });
     }).onError((error, stackTrace){});
    // debugPrint("ReponseList length in repo is ${responses.length}");
    return responses;
  }

}
