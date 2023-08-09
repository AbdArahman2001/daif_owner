import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/enum_data.dart';
import '../../../../utill/styles_manager.dart';

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({required this.controller});

  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme
              .of(context)
              .focusColor),
      child: DropdownButton<Month>(
          value: controller.selectedMonth,
          underline: SizedBox.shrink(),
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.expand_more,color: ColorManager.complementaryColor,),
          items: Month.values
              .map((month) =>
              DropdownMenuItem<Month>(
                  alignment: Alignment.center,
                  value: month,
                  child: Text(
                    month.month2Name(context),
                    style: style_500_12(controller.selectedMonth == month?ColorManager.complementaryColor:ColorManager.blackTextColor),
                  )))
              .toList(),
          onChanged: controller.selectCalendarMonth),
    );
  }
}
