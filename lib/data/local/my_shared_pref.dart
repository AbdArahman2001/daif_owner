import 'dart:convert';
import 'dart:developer';

import 'package:daif_owner/data/model/response/remembered_user.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../localization/l10n.dart';
import '../../main.dart';
import '../../main.dart';
import '../../utill/app_constants.dart';
import '../model/response/user_model.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  static final instance = MySharedPref._();
  static late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(AppConstants.currentLocaleKey, languageCode);

  Locale getCurrentLocal() {
    String? langCode =
        _sharedPreferences.getString(AppConstants.currentLocaleKey);
    // default language is english
    if (langCode == null) {
      return L10n.supportedLocales["ar"] ?? const Locale("ar"); // english
    }
    return L10n.supportedLocales[langCode] ?? const Locale("ar");
  }

  bool isOnBoardingShown() {
    final bool? isShown =
        _sharedPreferences.getBool(AppConstants.shownOnBoarding);
    return isShown ?? false;
  }

  void setOnBoardingShow() {
    _sharedPreferences.setBool(AppConstants.shownOnBoarding, true);
  }

  saveUserInfo(Map<String, dynamic> userInfo) {
    _sharedPreferences.setString(AppConstants.userInfo, jsonEncode(userInfo));
  }

  rememberUser(RememberedUser user){
    _sharedPreferences.setString(AppConstants.rememberedUser,json.encode(user.toJson()));
  }

  RememberedUser? getRememberedUser(){
    try {
      final  Object? user = _sharedPreferences.get(
          AppConstants.rememberedUser);
      if (user == null) return null;
      final Map<String,String?> jsonData = Map.from(json.decode(user.toString()));
      // log("------------------------- ${jsonDecode(jsonData)}");

      return RememberedUser.fromJson(jsonData);

    }catch(e){
      log("--------------------- error in getting remembered user: $e");
      return null;
    }
  }

  UserModel? getUserInfo() {
    final String? userDataAsString =
        _sharedPreferences.getString(AppConstants.userInfo);
    if (userDataAsString == null) return null;
    return UserModel.fromLocaleJson(jsonDecode(userDataAsString));
  }

  Future<void> clearUserInfo() async => await _sharedPreferences.remove(AppConstants.userInfo);

  /// clear all data from shared pref
  Future<void> clear() async => await _sharedPreferences.clear();
}
