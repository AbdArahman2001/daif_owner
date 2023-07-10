import 'dart:developer';

import 'package:daif_owner/controller/bookings_controller.dart';
import 'package:daif_owner/controller/dashboard_controller.dart';
import 'package:daif_owner/view/screens/bookings/screen/bookings_screen.dart';
import 'package:daif_owner/view/screens/calendar/screen/calendar_screen.dart';
import 'package:daif_owner/view/screens/my_places/screen/chalets_screens.dart';
import 'package:daif_owner/view/screens/my_places/screen/my_places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:get/get.dart';

import '../../../../controller/my_places_controller.dart';
import '../../../../helper/network_info.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final itemsTitles = [
      locale.bookings,
      locale.calendar,
      locale.places,
      locale.statistics
    ];
    return GetBuilder<DashBoardController>(builder: (controller){
      return WillPopScope(
        onWillPop: () async {
          if ( controller.pageIndex != 0) {
            controller.setPage(0);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
            key: controller.scaffoldKey,
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r), topRight: Radius.circular(32.r)),
              child: BottomNavigationBar(
                currentIndex: controller.pageIndex,
                type: BottomNavigationBarType.fixed,
                items: itemsTitles.map((e) {
                  int index = itemsTitles.indexOf(e);
                  return BottomNavigationBarItem(
                      icon: Icon(controller.tabBarIcons[index]), label: e);
                }).toList(),
                onTap: (int index) {
                  controller.setPage(index);
                },
              ),
            ),
            body: controller.currentPage
        ),
      );
    });
  }
}
