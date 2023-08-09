import 'package:daif_owner/controller/bookings_controller.dart';
import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/calendar_booking_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/view/screens/bookings/widget/pending_booking_short_info_widget.dart';
import 'package:daif_owner/view/screens/calendar/widget/calendar_booking_short_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
import '../../bookings/screen/booking_details_screen.dart';

class SingleDayWidget extends StatelessWidget {
  const SingleDayWidget({
    Key? key,
    required this.isBooked,
    required this.textColor,
    required this.bookingDate,
    required this.dayName,
    required this.bookingModel,
  }) : super(key: key);
  final Color textColor;
  final BookingDateModel bookingDate;
  final String dayName;
  final bool isBooked;
  final CalendarBookingModel? bookingModel;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return InkWell(
      onTap: () {
        if (isBooked) {
          // show the customer info
          final dialog = AlertDialog(
            content: CalendarBookingShortInfoWidget(
                bookingModel: CalendarBookingModel(
                  id: bookingModel!.id,
                  day: bookingModel!.day,
                  customerName: bookingModel!.customerName,
                  customerPhoneNumber: bookingModel!.customerPhoneNumber,
                  paidAmount: bookingModel!.paidAmount,
                  bookingPrice: bookingModel!.bookingPrice,
                ),
                bookingDate: bookingDate),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.only(bottom: 8.h),
            actions: [
              TextButton(
                child: Text(locale.show_full_information),
                onPressed: () async {
                  Get.back();
                  final controller = Get.find<CalendarController>();
                  final result =
                      await controller.getBookingInfo(bookingModel!.id);
                  if (result) {
                    Get.to(() => BookingDetailsScreen(
                        bookingModel: controller.currentBookingModel!));
                  }
                },
              ),
            ],
          );
          showDialog(context: context, builder: (context) => dialog);
        } else {
          final controller = Get.find<BookingsController>();
          controller.setBookingDate(bookingDate);
          Get.toNamed(Routes.addNewBooking)?.then((value) async{
            final controller = Get.find<CalendarController>();
            await controller.getMyChaletsAndCalendarBookings();
          });

        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color:
              isBooked ? ColorManager.complementaryColor : ColorManager.white1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              bookingDate.day.toString(),
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
