import 'package:daif_owner/data/model/response/service_model.dart';
import 'package:daif_owner/helper/data_converter.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleServiceWidget extends StatelessWidget {
  const SingleServiceWidget({Key? key, required this.service}) : super(key: key);
  final ServiceModel service;

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
          child: CustomCachedNetworkImage(imageUrl: service.icon,),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(DataConverter.key2NameService(context, service.icon))
      ],
    );
  }
}
