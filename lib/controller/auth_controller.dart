import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:daif_owner/data/local/my_shared_pref.dart';
import 'package:daif_owner/data/model/response/remembered_user.dart';
import 'package:daif_owner/data/model/response/user_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:daif_owner/view/screens/auth/screen/otp_screen.dart';
import 'package:daif_owner/view/screens/dashboard/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/login_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/api_checker.dart';
import '../main.dart';
import '../routes/app_pages.dart';
import 'dashboard_controller.dart';

enum LoginMethod { login, register }

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    log("----------- on init called");
    getRememberedUser();
  }

  final registerFormKey = GlobalKey<FormState>(debugLabel: "register_key");
  final loginFormKey = GlobalKey<FormState>(debugLabel: "login_key");
  final AuthRepo authRepo = AuthRepo.instance;
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  String governorateId = "1";
  XFile? profileImage;

  // LoginMethod loginMethod = LoginMethod.register;
  // late  UserModel userModel;
  bool rememberMe = false;
  bool isTermsAndConditions = false;

  @override
  void dispose() {
    super.dispose();
    clearData();
  }

  getRememberedUser() {

    final RememberedUser? user = MySharedPref.instance.getRememberedUser();
    log("setting user phone number and password: ${user?.phoneNumber??""} ${user?.password??""}");
    if (user !=null) {
      phoneNumberController.text = user.phoneNumber ?? "";
      passwordController.text = user.password ?? "";
    }
  }

  void registerAndSendOtp(BuildContext context) async {
    if (!(registerFormKey.currentState!.validate())) return;
    if (profileImage == null) {
      final locale = MyLocalizations.translate(context);
      CustomSnackBar.instance
          .showCustomErrorToast(message: locale.upload_your_profile_image);
      return;
    }

    final result = await _register();
    if (result) {
      final otpResult = await _sendOtp();
      if (otpResult) {
        clearData();
        Get.off(Routes.otp);
      }
    }
  }

  Future<bool> verifyOtp() async {
    ApiResponse apiResponse =
        await authRepo.verifyOtp(otpController.text.trim());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      CustomSnackBar.instance.showCustomToast(message: "otp verified");
      userInfo!.verify = true;
      authRepo.saveUserInfo(userInfo!.toLocaleJson(TokenType.login));
      Get.offNamed(Routes.dashboard);
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  resendOtp() async {
    log("----------- resend otp");
    await _sendOtp();
  }

  Future<bool> _sendOtp() async {
    // log("user token: ${userInfo?.accessToken}");
    ApiResponse apiResponse = await authRepo.sendOtp();
    // log("sending otp with token: ${userInfo?.accessToken}");
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      CustomSnackBar.instance.showCustomToast(message: "otp sent");
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  Future<bool> _register() async {
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
      registerFormKey.currentState!.dispose();
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  Future<void> login() async {
    if (!(loginFormKey.currentState!.validate())) return;
    ApiResponse apiResponse = await authRepo.login(
      LoginModel(
          phoneNumber: phoneNumberController.text.trim(),
          password: passwordController.text.trim()),
    );

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      final tempUserInfo =
          UserModel.fromApiJson(apiResponse.response!.data["data"]);
      userInfo = tempUserInfo;
      authRepo.dioClient.updateHeaders();
      if (tempUserInfo.verify != null && tempUserInfo.verify!) {
        authRepo.saveUserInfo(userInfo!.toLocaleJson(TokenType.login));
        if (rememberMe) {
          authRepo.rememberUser(RememberedUser(
              phoneNumber: phoneNumberController.text,
              password: passwordController.text));
        }
        Get.lazyPut(() => DashBoardController());
        Get.off(()=>const DashboardScreen());
        clearData();
      } else {
        CustomSnackBar.instance.showCustomErrorToast(
            message: "please verify your phone number before");
        _sendOtp();
        Get.toNamed(Routes.otp);
        clearData();
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  void pickProfileImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: source, imageQuality: Helper.getImageQuality(source));
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

  clearData() {
    log("------------------------ Data cleared");
    profileImage = null;
    phoneNumberController.clear();
    passwordController.clear();
    fullNameController.clear();
    emailController.clear();
    otpController.clear();
  }
}
