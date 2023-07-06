import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/enum_data.dart';
import '../../../../utill/styles_manager.dart';

class YearSelectorWidget extends StatelessWidget {
  const YearSelectorWidget({required this.controller});

  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme
              .of(context)
              .accentColor),
      child: DropdownButton<int>(
          value: controller.selectedYear,
          underline: SizedBox.shrink(),
          iconEnabledColor: Colors.white,
          dropdownColor: Theme
              .of(context)
              .accentColor,
          icon: const Icon(Icons.expand_more),
          items: controller.availableYears
              .map((year) =>
              DropdownMenuItem<int>(
                  alignment: Alignment.center,
                  value: year,
                  child: Text(
                    year.toString(),
                    style: style_500_12(Colors.white),
                  )))
              .toList(),
          onChanged: controller.selectYear),
    );
  }
}
