import 'dart:io';

import 'package:daif_owner/controller/auth_controller.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/view/basewidget/empty_app_bar.dart';
import 'package:daif_owner/view/screens/auth/widget/auth_method_tab_button.dart';
import 'package:daif_owner/view/screens/auth/widget/login_part_widget.dart';
import 'package:daif_owner/view/screens/auth/widget/signup_part_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/helper.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.onBoardingImg1,
                    fit: BoxFit.cover,
                    width: 60.w,
                    height: 60.w,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    controller: authController.fullNameController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: locale.full_name,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
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
                    controller: authController.emailController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: locale.email,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: authController.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: locale.password,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 320.w,
                      height: 160.w,
                      child: DottedBorder(
                        radius: Radius.circular(12.r),
                        color: ColorManager.grey1,
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        dashPattern: <double>[5, 5],
                        child: Center(
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                authController.profileImage != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    File(authController.profileImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const SizedBox(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () => Helper.openImageSourceDialog(
                                      context, authController.pickProfileImage),

                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SignUpPartWidget(
                    signUpFunc: authController.registerAndSendOtp,
                    isTermsAndConditions:
                    authController.isTermsAndConditions,
                    changeTermsAndConditions:
                    authController.changeTermsAndConditions,
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


