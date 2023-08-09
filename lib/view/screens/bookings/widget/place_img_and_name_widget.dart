import 'package:daif_owner/localization/my_localizations.dart';
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
      required this.bookingPrice, required this.paidAmount})
      : super(key: key);
  final String placeName;
  final num bookingPrice;
  final num paidAmount;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placeName,
              style: style_500_18(ColorManager.blackTextColor.withOpacity(0.8)),
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Text("${locale.paid_amount}:  " ,style: style_500_14(ColorManager.blackTextColor),),
                Text(
                  "$paidAmount ${AppConstants.currency}",
                  style: style_500_16(ColorManager.complementaryColor),
                ),
              ],
            ),
            Row(
              children: [
                Text("${locale.remaining_amount}:  " ,style: style_500_14(ColorManager.blackTextColor),),
                Text(
                  "${bookingPrice - paidAmount} ${AppConstants.currency}",
                  style: style_500_16(ColorManager.complementaryColor),
                ),
              ],
            ),

          ],
        )
      ],
    );
  }
}
