import 'package:daif_owner/controller/bookings_controller.dart';
import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/helper/enum_data.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:daif_owner/view/screens/calendar/widget/calendar_booking_short_info_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
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
        builder: (calendarController) {
          return Scaffold(
            appBar: CustomAppBar(
              title: locale.calendar,
              actions: const [SizedBox.shrink()],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<BookingsController>(builder: (bookingController) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            locale.choose_the_chalet,
                            style: style_400_16(ColorManager.blackTextColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            // padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1),
                                borderRadius: BorderRadius.circular(12)),
                            child: DropdownButton<int>(
                                borderRadius: BorderRadius.circular(15),
                                value: bookingController.selectedChaletId,
                                underline: const SizedBox.shrink(),
                                iconEnabledColor:
                                    Theme.of(context).primaryColor,
                                icon: const Icon(Icons.expand_more),
                                items: bookingController.chaletsInfo!
                                    .map((chalet) => DropdownMenuItem<int>(
                                        alignment: Alignment.centerLeft,
                                        value: chalet.id,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Text(
                                            chalet.name,
                                            style: style_500_16(
                                                Theme.of(context).primaryColor),
                                          ),
                                        )))
                                    .toList(),
                                onChanged:
                                    calendarController.changeSelectedChalet),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          BookingPeriodWidget(
                              selectedPeriod:
                                  bookingController.selectedBookingPeriod,
                              changeSelectedPeriod:
                                  bookingController.changeSelectedPeriod),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 12.h,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Theme.of(context).dialogBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Text(
                                locale.bookings_calendar,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            MonthSelectorWidget(
                              controller: calendarController,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            YearSelectorWidget(controller: calendarController),
                            SizedBox(
                              width: 12.w,
                            ),
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
                          bookings: calendarController.calendarBookings,
                          monthDaysCount: calendarController.selectedMonth
                              .getDaysCount(calendarController.selectedYear),
                          bookedDays: calendarController.calendarBookings
                              .map((booking) => booking.day)
                              .toList(),
                          dateTime: DateTime(calendarController.selectedYear,
                              (calendarController.selectedMonth.index + 1), 1),
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
