import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_services.dart';
import '../../model/sign_up_payload.dart';
import '../../utils/app_helper/app_url.dart';

class SignUpRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<String> registrationAPI(SignUpPayloadModel model) async {
    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };

    dynamic res;

    try {
      res = NetworkApiServices()
          .postAPIWithHeader(AppUrl.signupCredEndPoint, model.toMap(), header);
      Map<String, dynamic> apiAns = await res;
      return "Success";
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signUpAPI(SignUpPayloadModel model) async {
    dynamic res;
    try {
      res = _apiServices.postAPI(AppUrl.signupOTPEndPoint, model.toMap());
      Map<String, dynamic> apiAns = await res;
      return apiAns['token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyOTP(String email, String otp) async {
    Map<String, String> header = {
      "Authorization": "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
      "Content-Type": "application/json; charset=UTF-8",
    };
    Map<String, String> data = {
      "otp": otp,
      "email": email,
    };
    dynamic res;
    try {
      res =
          _apiServices.postAPIWithHeader(AppUrl.verifyUserSignup, data, header);
      Map<String, dynamic> apiAns = await res;
      return "$apiAns User is Verified, Now User can Login";
    } catch (e) {
      rethrow;
    }
  }
}
