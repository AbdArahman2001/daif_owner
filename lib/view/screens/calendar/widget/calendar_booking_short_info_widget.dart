import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/calendar_booking_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:daif_owner/view/screens/bookings/screen/booking_details_screen.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_id_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_time_and_date_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/place_img_and_name_widget.dart';
import 'package:daif_owner/view/screens/my_places/widget/chalet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/bookings_controller.dart';

class CalendarBookingShortInfoWidget extends StatelessWidget {
   CalendarBookingShortInfoWidget({Key? key, required this.bookingModel, required this.bookingDate})
      : super(key: key);
  final CalendarBookingModel bookingModel;
  final BookingDateModel bookingDate;
  final controller = Get.find<BookingsController>();
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingIDWidget(id: bookingModel.id),
        SizedBox(
          height: 2.h,
        ),
        PlaceImgAndNameWidget(
            placeName: bookingModel.customerName,
            bookingPrice: bookingModel.bookingPrice,paidAmount: bookingModel.paidAmount,),
        SizedBox(
          height: 8.h,
        ),
        Divider(),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            const Icon(Icons.calendar_month),
            SizedBox(
              width: 12.w,
            ),
            BookingTimeAndDateWidget(bookingDate: bookingDate.toStringInfo(),),
            const Expanded(child: SizedBox()),
            Text(
              "${locale.total} :  ",
              style: style_500_14(ColorManager.blackTextColor),
            ),
            Text(
              "${bookingModel.bookingPrice}\$",
              style: style_600_14(ColorManager.complementaryColor),
            )
          ],
        )
      ],
    );
  }
}
