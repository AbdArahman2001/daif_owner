import 'package:daif_owner/utill/app_constants.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceImgAndNameWidget extends StatelessWidget {
  const PlaceImgAndNameWidget(
      {Key? key,
      required this.placeName,
      required this.bookingPrice})
      : super(key: key);
  final String placeName;
  final double bookingPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placeName,
              style: style_500_14(ColorManager.blackTextColor.withOpacity(0.8)),
            ),
            Text(
              "$bookingPrice\$",
              style: style_500_14(ColorManager.complementaryColor),
            )
          ],
        )
      ],
    );
  }
}
