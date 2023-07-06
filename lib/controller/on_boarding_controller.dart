import 'package:daif_owner/data/local/my_shared_pref.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  OnBoardingController() {
    pageController = PageController();
  }

  late PageController pageController;
  int index = 0;

  void controlNavigation(int screensCount) {
    if (index + 1 == screensCount) {
      skip();
    } else {
      goNextPage();
    }
  }

  void skip() {
    Get.offNamed(Routes.login);
    MySharedPref.instance.setOnBoardingShow();
  }

  changePage(int index) {
    this.index = index;
    update();
  }

  goPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  goNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
