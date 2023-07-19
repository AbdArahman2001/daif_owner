import 'dart:io';

import 'package:daif_owner/controller/bookings_controller.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/screens/my_places/widget/add_place_images_widget.dart';
import 'package:daif_owner/view/screens/my_places/widget/choose_services_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/my_places_controller.dart';
import '../../../../data/model/response/booking_time_model.dart';
import '../../../../helper/helper.dart';
import '../../../../localization/my_localizations.dart';
import '../../../basewidget/custom_app_bar.dart';

class AddOrUpdateBookingScreen extends StatelessWidget {
  const AddOrUpdateBookingScreen(
      {Key? key, required this.isEditMode, this.bookingId, this.chaletName})
      : super(key: key);
  final bool isEditMode;
  final int? bookingId;
  final String? chaletName;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: locale.new_booking,
        actions: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<BookingsController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  isEditMode ? locale.chalet_name : locale.choose_the_chalet,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                isEditMode
                    ? Text(
                        chaletName!,
                        style: style_500_16(Theme.of(context).primaryColor),
                      )
                    : Container(
                        // width: MediaQuery.of(context).size.width * .4,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        // alignment: Alignment.centerLeft,
                        child: DropdownButton<int>(
                            value: controller.selectedChaletId,
                            underline: const SizedBox.shrink(),
                            iconEnabledColor: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.expand_more),
                            items: controller.chaletsInfo!
                                .map((chalet) => DropdownMenuItem<int>(
                                    alignment: Alignment.centerLeft,
                                    value: chalet.id,
                                    child: Text(
                                      chalet.name,
                                      style: style_500_16(
                                          Theme.of(context).primaryColor),
                                    )))
                                .toList(),
                            onChanged: controller.changeSelectedChalet),
                      ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.booking_date,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () => controller.pickdate(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.bookingDate != null
                          ? Text(
                              "${controller.bookingDate?.day}-${controller.bookingDate?.month}-${controller.bookingDate?.year}",
                              style:
                                  style_400_16(Theme.of(context).primaryColor),
                            )
                          : const Text("00-00-00"),
                      SizedBox(
                        width: 70.w,
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.choose_the_period,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // alignment: Alignment.centerLeft,
                  child: DropdownButton<BookingPeriod>(
                      value: controller.selectedBookingPeriod,
                      underline: const SizedBox.shrink(),
                      iconEnabledColor: Theme.of(context).primaryColor,
                      icon: const Icon(Icons.expand_more),
                      items: BookingPeriod.values
                          .map((period) => DropdownMenuItem<BookingPeriod>(
                              alignment: Alignment.centerLeft,
                              value: period,
                              child: Text(
                                period.translate(context),
                                style: style_500_16(
                                    Theme.of(context).primaryColor),
                              )))
                          .toList(),
                      onChanged: controller.changeSelectedPeriodWithoutGetDate),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.customer_name,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.customerNameController,
                  decoration: const InputDecoration(hintText: "Mohammed Ahmed"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.phone_number,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.phoneNumberController,
                  decoration: const InputDecoration(hintText: "05xxxxxxxx"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.identity_number,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.customerIdentity,
                  decoration: const InputDecoration(hintText: "xxxxxxxxx"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.booking_price,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.bookingPriceController,
                  decoration: const InputDecoration(hintText: "500"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.paid_amount,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.paidAmountController,
                  decoration: const InputDecoration(hintText: "100"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.number_of_persons,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.numberOfPersonsControllers,
                  decoration: const InputDecoration(hintText: "15"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                AddPlaceImagesWidget(
                    removeImg: controller.removeImage,
                    maxImagesNumber: 2,
                    dimensions: MediaQuery.of(context).size.width * .45,
                    pickMultiImage: controller.pickMultiImage,
                    pickedImages: controller.chosenBookingAttachments ?? []),
                SizedBox(
                  height: 40.h,
                ),
                CustomElevatedButton(
                    onPressed: () async {
                      if (isEditMode) {
                        controller.updateBookingWithItsAttachments(bookingId!);
                        Get.back<bool>();
                      } else {
                        await controller.createNewBookingWithItsAttachments();
                      }
                      Get.back<bool>();
                    },
                    child: Text(isEditMode ? locale.update : locale.save)),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
