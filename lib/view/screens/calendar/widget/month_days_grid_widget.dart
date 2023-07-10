import 'package:daif_owner/view/screens/calendar/widget/single_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/helper.dart';
import '../../../../utill/color_manager.dart';

class MonthDaysGridWidget extends StatelessWidget {
  const MonthDaysGridWidget(
      {Key? key,
      required this.monthDaysCount,
      required this.bookedDays,
      required this.selectFunc,
      required this.dateTime})
      : super(key: key);
  final int monthDaysCount;
  final DateTime dateTime;
  final List<int> bookedDays;
  final void Function(String day) selectFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, childAspectRatio: 47 / 54),
          itemCount: monthDaysCount,
          itemBuilder: (context, index) {
            final bool isBooked = bookedDays.contains((index + 1));
            return SingleDayWidget(
                selectFunc: selectFunc,
                backgroundColor: isBooked
                    ? ColorManager.complementaryColor
                    : ColorManager.white1,
                textColor:
                    isBooked ? Colors.white : ColorManager.blackTextColor,
                dayNumber: index + 1,
                dayName: Helper.getDayNameFromDate(dateTime,index+1));
          }),
    );
  }
}
