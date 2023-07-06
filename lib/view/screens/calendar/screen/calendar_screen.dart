import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/helper/enum_data.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../widget/booking_period_widget.dart';
import '../widget/month_days_grid_widget.dart';
import '../widget/month_selector_day.dart';
import '../widget/year_selector_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return GetBuilder<CalendarController>(
      init: CalendarController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(title: locale.calendar,actions: const SizedBox.shrink(),),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  BookingPeriodWidget(selectedPeriod: controller.selectedPeriod, changeSelectedPeriod: controller.changeSelectedPeriod),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Theme
                          .of(context)
                          .dialogBackgroundColor,
                    ),
                    child: Column(
                      children: [

                        SizedBox(height: 30.h,),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              locale.select_days,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                            Expanded(child: SizedBox()),
                            MonthSelectorWidget(
                              controller: controller,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            YearSelectorWidget(controller: controller),

                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Divider(color: ColorManager.dividerColor),
                        SizedBox(
                          height: 8.h,
                        ),
                        MonthDaysGridWidget(
                          monthDaysCount: controller.selectedMonth.getDaysCount(controller.selectedYear),
                          bookedDays: controller.bookedDaysAtMonth,
                          month: controller.selectedMonth.index + 1,
                          selectFunc: controller.changeDayStatus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}





