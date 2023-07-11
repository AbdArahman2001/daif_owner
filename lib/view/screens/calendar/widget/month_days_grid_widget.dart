import 'package:daif_owner/data/model/response/calendar_booking_model.dart';
import 'package:daif_owner/view/screens/calendar/widget/single_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/booking_time_model.dart';
import '../../../../helper/helper.dart';
import '../../../../utill/color_manager.dart';

class MonthDaysGridWidget extends StatelessWidget {
  const MonthDaysGridWidget(
      {Key? key,
      required this.monthDaysCount,
      required this.bookedDays,
      required this.dateTime,
      required this.bookings})
      : super(key: key);
  final int monthDaysCount;
  final DateTime dateTime; // selected_year/selected_month/1
  final List<int> bookedDays;
  final List<CalendarBookingModel> bookings;

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
            final calendarBooking = isBooked
                ? bookings.firstWhere((booking) => booking.day == index + 1)
                : null;
            return SingleDayWidget(
                bookingModel: calendarBooking,
                isBooked: isBooked,
                textColor:
                    isBooked ? Colors.white : ColorManager.blackTextColor,
                bookingDate: BookingDateModel(
                    year: dateTime.year,
                    month: dateTime.month,
                    day: index + 1),
                dayName: Helper.getDayNameFromDate(dateTime, index + 1));
          }),
    );
  }
}
