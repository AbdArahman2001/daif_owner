import 'package:daif_owner/data/local/my_shared_pref.dart';
import 'package:daif_owner/helper/enum_data.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class ProfileController extends GetxController {
  final AuthRepo authRepo = AuthRepo.instance;

  LanguageType languageGroup = LanguageType.arabic;
  void changeLanguage(LanguageType? languageType){
    if(languageType == null) return;
    languageGroup = languageType;
    Get.updateLocale(Locale(languageType.getLanguageCode()));
    MySharedPref.instance.setCurrentLanguage(languageType.getLanguageCode());
    Get.back();
  }

  logout()async{

    authRepo.logout();

  }

}
