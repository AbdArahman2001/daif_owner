import 'package:daif_owner/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utill/styles_manager.dart';

class CustomPinCodeWidget extends StatelessWidget {
  const CustomPinCodeWidget(
      {Key? key,
        required this.onComplete,
        required this.controller, required this.fieldWidth,
      })
      : super(key: key);
  final ValueChanged<String> onComplete;
  final TextEditingController controller;
final double fieldWidth;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(

      textStyle: style_700_24(Theme.of(context).primaryColor),
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.number,
      length: AppConstants.otpLength,
      obscureText: false,
      animationType: AnimationType.scale,
      blinkWhenObscuring: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12.r),
        fieldHeight: fieldWidth,
        fieldWidth:fieldWidth,
        activeFillColor: Theme.of(context).focusColor,
        activeColor: Theme.of(context).hintColor,
        selectedColor: Theme.of(context)
            .inputDecorationTheme
            .focusedBorder!
            .borderSide
            .color,
        errorBorderColor: Theme.of(context).errorColor,
        inactiveColor: Theme.of(context)
            .inputDecorationTheme
            .enabledBorder!
            .borderSide
            .color,
        inactiveFillColor: Theme.of(context).focusColor,
        selectedFillColor: Theme.of(context).focusColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      enableActiveFill: true,
      errorAnimationController: null,
      autoDisposeControllers: false,
      controller: controller,
      onCompleted: onComplete,
      onChanged: (_) {},
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}
