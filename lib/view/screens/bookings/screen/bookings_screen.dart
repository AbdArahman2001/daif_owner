import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:daif_owner/view/screens/bookings/widget/bookings_status_tab_bar_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/pending_booking_short_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
                    physics: ClampingScrollPhysics(),
                    itemCount: 3,
                    onPageChanged: controller.changeSelectedStatus,
                    itemBuilder: (context, index) {
                      return RefreshIndicator(
                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                          onRefresh: () async => controller.refreshBookings(),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount: controller.allBookings?.length,
                                  itemBuilder: (context, index) {
                                    return controller.allBookings == null
                                        ? const SizedBox()
                                        : PendingBookingShortInfoWidget(
                                            bookingModel:
                                                controller.allBookings![index]);
                                  }),
                            );
                          }));
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
