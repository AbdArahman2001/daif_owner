import 'package:booking_calendar/booking_calendar.dart';
import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../view/screens/bookings/screen/bookings_screen.dart';
import '../view/screens/calendar/screen/calendar_screen.dart';
import '../view/screens/my_places/screen/chalets_screens.dart';
import 'bookings_controller.dart';
import 'my_places_controller.dart';

class DashBoardController extends GetxController {

  int pageIndex = 0;
  late Widget currentPage;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
  bool singleVendor = false;
  late final List<IconData> tabBarIcons;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => MyPlacesController());
    Get.lazyPut(() => CalendarController());
    Get.put<BookingsController>(BookingsController(), permanent: true);
    currentPage = const BookingsScreen();
    tabBarIcons = [
      Icons.format_list_bulleted,
      Icons.calendar_month,
      Icons.chalet,
      Icons.bar_chart,
    ];
  }

  void setPage(int pageIndex)async {
    this.pageIndex = pageIndex;
    switch(pageIndex){
      case 0:
        currentPage = BookingsScreen();
        break;
      case 1:
        final controller = Get.find<CalendarController>();
        final bool result = await controller.getMyChaletsAndCalendarBookings();
        if(result) {
          currentPage = CalendarScreen();
        }
        break;
      case 2:
        final controller = Get.find<MyPlacesController>();
        controller.getAllChalets();
        currentPage = ChaletsScreen();
        break;
      case 3:
        currentPage = Scaffold();
        break;
    }
    update();
  }
}