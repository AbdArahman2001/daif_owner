import 'dart:developer';

import 'package:daif_owner/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/styles_manager.dart';
import '../../../basewidget/button/custom_elevated_button.dart';
import '../../../basewidget/custom_app_bar.dart';
import '../widget/custom_pin_code_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          appBar: CustomAppBar(title: "test"),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text(
                          "${"code sent to"} +97059****93",
                          style: style_400_18(Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 72.h,
                      ),
                      CustomPinCodeWidget(
                        fieldWidth: MediaQuery.of(context).size.width / 8,
                        onComplete: (String val) {
                          log(val);
                        },
                        controller: authController.otpController,
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      TextButton(
                        onPressed: authController.resendOtp,
                        child: Text(
                          "resend otp",
                          style: style_500_18(Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                      CustomElevatedButton(
                        child: Text("verfy"),
                        onPressed: authController.verifyOtp,
                      ),
                      SizedBox(
                        height: 46.h,
                      ),
                    ]),
              )));
    });
  }
}
