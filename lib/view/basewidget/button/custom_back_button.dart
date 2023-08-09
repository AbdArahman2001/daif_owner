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
      width: 50.w,
      height: 50.w,
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorManager.arrowBackIconColor,
        ),
      ),
    );
  }
}
