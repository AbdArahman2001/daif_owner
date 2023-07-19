import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:daif_owner/view/screens/bookings/widget/bookings_status_tab_bar_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/pending_booking_short_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/bookings_controller.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return GetBuilder<BookingsController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
          title: locale.home,
          leading: IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              BookingsStatusTabBarWidget(
                controller: controller,
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageViewController,
                    onPageChanged: controller.changeSelectedStatus,
                    itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                        children: controller.allBookings
                            .map((booking) => PendingBookingShortInfoWidget(
                                bookingModel: booking))
                            .toList()),
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await controller.getChaletIdWithName()) {
              Get.toNamed(Routes.addNewBooking);
            }
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
