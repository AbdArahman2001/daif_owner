import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, this.onPressed}) : super(key: key);
final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ValuesManager.border),
            ),
            side: const BorderSide(
                color: ColorManager.arrowBackIconColor, width: 0.7),
            ),
        onPressed:onPressed??() => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ColorManager.arrowBackIconColor,
        ),
      ),
    );
  }
}
