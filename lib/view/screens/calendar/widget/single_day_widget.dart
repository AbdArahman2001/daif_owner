import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utill/styles_manager.dart';

class SingleDayWidget extends StatelessWidget {
  const SingleDayWidget({Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.dayNumber,
    required this.dayName, required this.selectFunc})
      : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final int dayNumber;
  final String dayName;
  final void Function(String day) selectFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> (){
       final dialog = AlertDialog();
        selectFunc(dayNumber.toString());
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dayNumber.toString(),
              style: style_600_15(textColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              dayName,
              style: style_400_8(textColor),
            ),
          ],
        ),
      ),
    );
  }
}
