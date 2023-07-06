
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
  final String selectedPeriod;
  final void Function(String) changeSelectedPeriod;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _SingleBookingPeriodWidget(
            isSelected: selectedPeriod == "p",
            title: locale.morning,
            image: IconAssets.sunIcon,
            onTap: () => changeSelectedPeriod("p")),
        _SingleBookingPeriodWidget(
            isSelected: selectedPeriod == "a",
            title: locale.evening,
            image: IconAssets.moonIcon,
            onTap: () => changeSelectedPeriod("a")),
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
