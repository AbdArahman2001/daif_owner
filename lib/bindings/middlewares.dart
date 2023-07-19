import 'package:daif_owner/data/local/my_shared_pref.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../main.dart';
import '../routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // if the tokenType:
    //  null: register screen,
    //  login: dashboard screen,
    //  register: login screen
    final TokenType? tokenType = userInfo?.tokenType;
    if (tokenType == null) {
      return const RouteSettings(name: Routes.register);
    }
    if (tokenType == TokenType.register) {
      return const RouteSettings(name: Routes.otp);
    }
    if (tokenType == TokenType.login) {
      return const RouteSettings(name: Routes.dashboard);
    }
    return null; // will not reach at this line.
  }
}

class OnBoardingMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    bool isShown = MySharedPref.instance.isOnBoardingShown();
    return isShown ? const RouteSettings(name: Routes.login) : null;
  }
}
