import 'dart:developer';

import 'package:daif_owner/view/screens/auth/screen/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData,MultipartFile;

import '../../routes/app_pages.dart';
import '../../utill/app_constants.dart';
import '../local/my_shared_pref.dart';
import '../model/response/base/api_response.dart';
import '../model/response/login_model.dart';
import '../model/response/user_model.dart';
import '../remote/dio/dio_client.dart';

class AuthRepo {
  AuthRepo._();

  static final instance = AuthRepo._();
  final DioClient dioClient = DioClient.dioClient;
  final sharedPreferences = MySharedPref.instance;

  sendOtp()async{
    try {
      dioClient.updateHeaders();
      Response response = await dioClient.post(
        AppConstants.sendOtp,
        data: {}
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  verifyOtp(String otpCode)async{
    try {
      Response response = await dioClient.post(
        AppConstants.verifyOtp,
        data: {"verify_code":otpCode}
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }



  Future<ApiResponse> register(UserModel userModel) async {
    try {
      String fileName = userModel.image.path.split('/').last;
      FormData data = FormData.fromMap({
        "profile_image": await MultipartFile.fromFile(
          userModel.image.path,
          filename: fileName,
        ),
        ...userModel.toApiJson()
      });
      Response response = await dioClient.post(
        AppConstants.registerUrl,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> login(LoginModel loginModel) async {
    try {
      Response response = await dioClient.post(
        AppConstants.loginUrl,
        data: loginModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> logout() async {
    try {
      Response response = await dioClient.post(
        AppConstants.logout,
        data: {},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }finally{
      MySharedPref.instance.clearUserInfo();
      Get.off(LoginScreen());
    }
  }

  // for  user token
  Future<void> saveUserInfo(Map<String, dynamic> userInfo)async {
    try {
      await sharedPreferences.saveUserInfo(userInfo);
    } catch (e) {
      rethrow;
    }
  }

  UserModel? getUserInfo() {
    return sharedPreferences.getUserInfo();
  }

// Future<ApiResponse> forgetPassword(String identity) async {
//   try {
//     Response response = await dioClient.post(AppConstants.for, data: {"identity": identity});
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
}
