import 'package:daif_owner/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/splash_controller.dart';
import '../../../helper/network_info.dart';
import '../../../routes/app_pages.dart';
import '../../../utill/assets_manager.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    NetworkInfo.checkConnectivity();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.offNamed(Routes.onBoarding));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(tag:"logo",child: Image.asset(ImageAssets.splashLogo)),
      ),
    );
  }
}
