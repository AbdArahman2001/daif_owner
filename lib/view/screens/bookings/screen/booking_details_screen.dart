import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_back_button.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_id_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_time_and_date_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/bookings_controller.dart';
import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
import '../../../basewidget/custom_app_bar.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key, required this.bookingModel})
      : super(key: key);
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: locale.booking_details,
        actions: SizedBox.shrink(),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<BookingsController>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${locale.booking} #${bookingModel.id}",
                    style: style_600_18(ColorManager.blackTextColor),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${bookingModel.bookingDate.toStringInfo()} | ${bookingModel.bookingPeriod.translate(context)}",
                    style: style_400_16(
                        ColorManager.primaryColor.withOpacity(0.8)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.place_name, value: bookingModel.chaletName),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.number_of_persons,
                      value: bookingModel.numberOfPersons?.toString() ?? "-"),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomDividerWidget(),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Text(
                        locale.finance_info,
                        style: style_600_18(ColorManager.blackTextColor),
                        textAlign: TextAlign.start,
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            locale.edit,
                            style: style_500_17(ColorManager.primaryColor),
                          ))
                    ],
                  ),
                  SingleInformationRow(
                      label: locale.booking_price,
                      value: bookingModel.bookingPrice.toString()),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.paid_amount,
                      value: bookingModel.paidAmount.toString()),
                  SizedBox(
                    height: 10.h,
                  ),
                  // SingleInformationRow(
                  //     label: locale.payment_method, value: locale.jawwal_pay),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  SingleInformationRow(
                      label: locale.remaining_amount,
                      value:
                          (bookingModel.bookingPrice - bookingModel.paidAmount)
                              .toString()),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomDividerWidget(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    locale.customer_info,
                    style: style_600_18(ColorManager.blackTextColor),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.full_name,
                      value: bookingModel.customerName),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "${locale.phone_number}:",
                            maxLines: 1,
                            style: style_400_16(ColorManager.grey2),
                          )),
                      Flexible(
                          flex: 1,
                          child: TextButton(
                            onPressed: () => Helper.navigateToCallingBoard(),
                            child: Text(
                              bookingModel.customerPhoneNumber,
                              style: style_600_16(ColorManager.primaryColor).copyWith(decoration: TextDecoration.underline),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.address, value: "NO Implementation Yet"),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleInformationRow(
                      label: locale.id_number, value: bookingModel.customerIdentity),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("${locale.id_confirmation_img}:",
                      style: style_400_16(ColorManager.grey2)),
                  SizedBox(
                    height: 12.h,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: controller.currentBookingAttachments
                          .map((attachment) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: CustomCachedNetworkImage(
                                      imageUrl: attachment.path,
                                      width:
                                          MediaQuery.of(context).size.width * .8,
                                      height: 200,
                                    )),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SingleInformationRow extends StatelessWidget {
  const SingleInformationRow(
      {Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "$label:",
              maxLines: 1,
              style: style_400_16(ColorManager.grey2),
            )),
        Flexible(
            flex: 1,
            child: Text(
              value,
              style: style_600_16(ColorManager.blackTextColor),
            )),
      ],
    );
  }
}
