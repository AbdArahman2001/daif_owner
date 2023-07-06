import 'package:daif_owner/controller/bookings_controller.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class BookingsStatusTabBarWidget extends StatelessWidget {
  const BookingsStatusTabBarWidget({Key? key, required this.controller})
      : super(key: key);
  final BookingsController controller;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final bookingsStatuses = [locale.current, locale.completed, locale.canceled];
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Theme.of(context).dialogBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bookingsStatuses.map((e) {
        final index = bookingsStatuses.indexOf(e);
        return _SingleTabBarItem(
            isSelected: controller.selectedTabIndex == index,
            title: e,
            index: index,
            onPressed: controller.changeSelectedStatus);
      }).toList()),
    );
  }
}

class _SingleTabBarItem extends StatelessWidget {
  const _SingleTabBarItem(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.index,
      required this.isSelected})
      : super(key: key);
  final String title;
  final void Function(int) onPressed;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: isSelected
                ? ColorManager.tabIconColor
                : Theme.of(context).dialogBackgroundColor),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 22.w),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () => onPressed(index),

          child: Text(
            title,
            style: isSelected
                ? style_600_14(Theme.of(context).primaryColor)
                : style_500_14(ColorManager.unSelectedTextColor),
          ),
        ));
  }
}
