import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:daif_owner/data/model/response/user_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:daif_owner/view/screens/auth/screen/otp_screen.dart';
import 'package:daif_owner/view/screens/dashboard/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/login_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/api_checker.dart';
import '../main.dart';
import '../routes/app_pages.dart';

enum LoginMethod { login, register }

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fullNameController.text = "Abedarhman";
    passwordController.text = "Pas@123";
    emailController.text = "testaccount3@gmail.com";
    phoneNumberController.text = "0591212301";
  }

  final AuthRepo authRepo = AuthRepo.instance;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
    TextEditingController otpController  = TextEditingController();
  String governorateId ="1";
  XFile? profileImage;

  // LoginMethod loginMethod = LoginMethod.register;
  // late  UserModel userModel;
  bool rememberMe = false;
  bool isTermsAndConditions = false;
  bool isLoading = false;

  void registerAndSendOtp()async {
    final result = await _register();
    if (result) {
      final otpResult = await _sendOtp();
      if(otpResult) {
        Get.off( const OtpScreen());
      }

    }
  }

  Future<bool> verifyOtp() async {
    isLoading = true;
    update();
    ApiResponse apiResponse = await authRepo.verifyOtp(otpController.text.trim());

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      CustomSnackBar.instance.showCustomToast(message: "otp verified");
      authRepo.saveUserInfo(userInfo!.toLocaleJson(TokenType.login));
      Get.to(const DashboardScreen());
      isLoading = false;
      return true;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  resendOtp()async{
    log("----------- resend otp");
    await _sendOtp();
  }

  Future<bool> _sendOtp() async {
    log("user token: ${userInfo?.accessToken}");
    isLoading = true;
    update();
    ApiResponse apiResponse = await authRepo.sendOtp();
    log("sending otp with token: ${userInfo?.accessToken}");
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      CustomSnackBar.instance.showCustomToast(message: "otp sent");
      isLoading = false;
      return true;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }


  Future<bool> _register() async {
    isLoading = true;
    update();
    ApiResponse apiResponse = await authRepo.register(
      UserModel(
          fullName: fullNameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          password: passwordController.text.trim(),
          email: emailController.text.trim(),
          image: profileImage!,
          governorateId: governorateId,
          verify: null),
    );

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      final data = Map<String, dynamic>.from(jsonDecode(
          jsonEncode(apiResponse.response!.data["data"]).toString()));
      userInfo = UserModel.fromApiJson(data);
      authRepo.saveUserInfo(userInfo!.toLocaleJson(TokenType.register));
      return true;
      } else {
        isLoading = false;
        update();
        ApiChecker.checkApi(apiResponse);
        return false;
      }
    }


    Future<void> login() async {
      isLoading = true;
      update();
      ApiResponse apiResponse = await authRepo.login(
        LoginModel(
            phoneNumber: phoneNumberController.text.trim(),
            password: passwordController.text.trim()),
      );

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200 &&
          apiResponse.response!.data["error"] == false) {
        userInfo = UserModel.fromApiJson(apiResponse.response!.data["data"]);
        authRepo.saveUserInfo(userInfo!.toLocaleJson(TokenType.login));
        Get.offNamed(Routes.dashboard);
        isLoading = false;
      } else {
        isLoading = false;
        update();
        ApiChecker.checkApi(apiResponse);
      }
    }

    void pickProfileImage(ImageSource source) async {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: source);
      if (image != null) {
        profileImage = image;
        update();
      }
    }

    changeTermsAndConditions(bool? value) {
      isTermsAndConditions = value ?? false;
      update();
    }

    changeRememberMe(bool? value) {
      rememberMe = value ?? false;
      update();
    }
  }
