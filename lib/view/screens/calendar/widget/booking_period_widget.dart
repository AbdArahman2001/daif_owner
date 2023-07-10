
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../localization/my_localizations.dart';
import '../../../../utill/assets_manager.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';

class BookingPeriodWidget extends StatelessWidget {
  const BookingPeriodWidget(
      {Key? key,
      required this.selectedPeriod,
      required this.changeSelectedPeriod})
      : super(key: key);
  final BookingPeriod selectedPeriod;
  final void Function(BookingPeriod bookingPeriod) changeSelectedPeriod;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _SingleBookingPeriodWidget(
            isSelected: selectedPeriod == BookingPeriod.morning,
            title: locale.morning,
            image: IconAssets.sunIcon,
            onTap: () => changeSelectedPeriod(BookingPeriod.morning)),
        _SingleBookingPeriodWidget(
            isSelected: selectedPeriod == BookingPeriod.evening,
            title: locale.evening,
            image: IconAssets.moonIcon,
            onTap: () => changeSelectedPeriod(BookingPeriod.evening)),
      ],
    );
  }
}

class _SingleBookingPeriodWidget extends StatelessWidget {
  const _SingleBookingPeriodWidget(
      {Key? key,
      required this.isSelected,
      required this.title,
      required this.image,
      required this.onTap})
      : super(key: key);
  final bool isSelected;
  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160.w,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).dialogBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image),
            Text(
              title,
              style: style_500_14(
                  isSelected ? Colors.white : ColorManager.blackTextColor),
            )
          ],
        ),
      ),
    );
  }
}
