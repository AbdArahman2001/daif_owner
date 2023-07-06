import 'package:daif_owner/utill/app_constants.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PlaceImgAndNameWidget extends StatelessWidget {
  const PlaceImgAndNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CustomCachedNetworkImage(imageUrl: AppConstants.dummyPlaceImg,height:44.h,width: 44.h ,),
        ),
        SizedBox(width: 12.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text("Unity Chalet",style: style_500_14(ColorManager.blackTextColor.withOpacity(0.8)),),
            Text("85.34\$",style: style_500_14(ColorManager.complementaryColor),)
          ],
        )
      ],
    );
  }
}