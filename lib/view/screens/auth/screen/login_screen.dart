import 'package:daif_owner/controller/auth_controller.dart';
import 'package:daif_owner/helper/validators.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/view/basewidget/empty_app_bar.dart';
import 'package:daif_owner/view/screens/auth/widget/auth_method_tab_button.dart';
import 'package:daif_owner/view/screens/auth/widget/login_part_widget.dart';
import 'package:daif_owner/view/screens/auth/widget/signup_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Form(
                key: authController.loginFormKey,
                child: Column(
                  children: [
                    Hero(
                      tag: "logo",
                      child: Image.asset(
                        ImageAssets.splashLogo,
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      validator: (input) =>
                          Validators.phoneNumberValidator(input, context),
                      controller: authController.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: locale.phone_number,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      validator: (input) =>
                          Validators.passwordValidator(input, context),
                      controller: authController.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: locale.password,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    LoginPartWidget(
                      loginFunc: authController.login,
                      isRememberMe: authController.rememberMe,
                      changeRememberMe: authController.changeRememberMe,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
