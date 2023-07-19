import 'dart:convert';

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
      return L10n.supportedLocales["en"] ?? const Locale("en"); // english
    }
    return L10n.supportedLocales[langCode] ?? const Locale("en");
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
