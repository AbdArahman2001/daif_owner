import 'package:daif_owner/helper/data_converter.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleServiceWidget extends StatelessWidget {
  const SingleServiceWidget({Key? key, required this.serviceKey}) : super(key: key);
  final String serviceKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54.w,
          height: 54.h,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorManager.borderColor)),
          child: Image.asset("assets/icons/$serviceKey.png"),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(DataConverter.key2NameService(context, serviceKey))
      ],
    );
  }
}
