import 'dart:developer';

import 'package:daif_owner/controller/bookings_controller.dart';
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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;
  late List<IconData> _tabBarIcons;

  @override
  void initState() {
    super.initState();
    Get.put<MyPlacesController>(MyPlacesController());
    Get.put<BookingsController>(BookingsController());
    _screens = [
      const BookingsScreen(),
      CalendarScreen(),
      ChaletsScreen(),
      Scaffold()
    ];
    _tabBarIcons = [
      Icons.format_list_bulleted,
      Icons.calendar_month,
      Icons.chalet,
      Icons.bar_chart,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final itemsTitles = [
      locale.bookings,
      locale.calendar,
      locale.places,
      locale.statistics
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r), topRight: Radius.circular(32.r)),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: itemsTitles.map((e) {
              int index = itemsTitles.indexOf(e);
              return BottomNavigationBarItem(
                  icon: Icon(_tabBarIcons[index]), label: e);
            }).toList(),
            onTap: (int index) {
              _setPage(index);
            },
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    log(pageIndex.toString());
    setState(() {
      _pageController.jumpToPage(pageIndex);
      if (pageIndex == 0) {
        final controller = Get.find<BookingsController>();
        controller.getAllBookings(1);
      } else if (pageIndex == 2) {
        final controller = Get.find<MyPlacesController>();
        controller.getAllChalets();
      }
      _pageIndex = pageIndex;
    });
  }
}
