import 'dart:developer';

import 'package:daif_owner/data/remote/dio/dio_client.dart';
import 'package:daif_owner/utill/app_constants.dart';
import 'package:daif_owner/view/basewidget/dialog/update_app_version_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:package_info_plus/package_info_plus.dart';

import '../data/model/response/base/api_response.dart';

class PackageInfoHelper {
   PackageInfoHelper._();

  final DioClient dioClient =  DioClient.dioClient;

  factory PackageInfoHelper() =>  PackageInfoHelper._();

  Future<String?> _getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      log("App version: ${packageInfo.version}");
      log("package name: ${packageInfo.packageName}");
      log("build number: ${packageInfo.buildNumber}");
      return packageInfo.version;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkAppVersion()async{
    try {
      Response response =
          await dioClient.get(AppConstants.appConfigurations);
      final String? appVersion =await _getAppVersion();
      final String? appMainVersion = appVersion?.split(".").first;
      final String? supportedVersion = response.data["version"];
      final String? supportedMainVersion = supportedVersion?.split(".").first;
      if(appMainVersion !=null && appMainVersion != supportedMainVersion){
        Get.dialog(const UpdateAppVersionDialog(),barrierDismissible: false);
        return false;
      }
      return true;

    } catch (e) {
      return false;
    }
  }

}
