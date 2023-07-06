import 'package:daif_owner/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../controller/on_boarding_controller.dart';
import '../controller/splash_controller.dart';
import '../main.dart';
import '../routes/app_pages.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

  }

}

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }

}

class OnBoardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());

  }

}

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());

  }

}


