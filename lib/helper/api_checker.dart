import 'dart:developer';

import 'package:daif_owner/data/local/my_shared_pref.dart';
import 'package:daif_owner/data/repository/auth_repo.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/error_codes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/response/base/api_response.dart';
import '../view/basewidget/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    late final String? errorMessage;
    try {
      if (apiResponse.error != null && apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        if (apiResponse.error is Exception) {
          if (apiResponse.error is DioExceptionType) {
            switch (apiResponse.error.type) {
              case DioExceptionType.cancel:
                errorMessage = "Request to API server was cancelled";
                break;
              case DioExceptionType.connectionTimeout:
                errorMessage = "Connection timeout with API server";
                break;
              case DioExceptionType.unknown:
                errorMessage =
                    "Connection to API server failed due to internet connection";
                break;
              case DioExceptionType.receiveTimeout:
                errorMessage = "Receive timeout in connection with API server";
                break;
              case DioExceptionType.badResponse:
                final DioError error = apiResponse.error;
                switch (apiResponse.error.response!.statusCode) {
                  case 401:
                    errorMessage = "Unauthenticated";
                    break;
                  case 404:
                  case 500:
                  case 503:
                    errorMessage = error.message;
                    break;
                  default:
                    errorMessage = error.response?.data["msg"];
                    break;
                }
                break;
              case DioErrorType.sendTimeout:
                errorMessage = "Send timeout with server";
                break;
            }
          } else if (apiResponse.error is DioException) {
            String? message = ((apiResponse.error as DioException)
                .response
                ?.data as Map<String, dynamic>)["msg"];
            errorMessage = ErrorCodesInfo.stringToErrorCode(
                    ((apiResponse.error as DioException).response?.data
                        as Map<String, dynamic>)["error_code"])
                .getErrorMessage(message,Get.context!);
          } else if (apiResponse.error is FormatException) {
            errorMessage = (apiResponse.error as FormatException).message;
          } else {
            errorMessage = "UnKnown";
          }
        } else {
          errorMessage = apiResponse.error.toString();
        }
      }
    } on Exception catch (e) {
      errorMessage = e.toString();
    }
    log("---------------------------- Api Checker:\n$errorMessage");
    if (errorMessage == "Unauthenticated") {
      AuthRepo authRepo = AuthRepo.instance;
      authRepo.logout();
    }
    CustomSnackBar.instance
        .showCustomErrorToast(message: errorMessage ?? "UnKnown");
  }

// called when an exception occurred to navigate to auth_screen or show error snackBar.
// static void checkApi(BuildContext context, ApiResponse apiResponse) {
//   if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
//     // Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
//     // Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
//     // Provider.of<AuthProvider>(context,listen: false).clearSharedData();
//     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
//   }else {
//     String _errorMessage;
//     if (apiResponse.error is String) {
//       _errorMessage = apiResponse.error.toString();
//     } else {
//       _errorMessage = apiResponse.error.errors[0].message;
//     }
//     print(_errorMessage);
//    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errorMessage, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
//   }
// }
}
