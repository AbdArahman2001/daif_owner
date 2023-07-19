import 'dart:developer';

import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/calendar_booking_model.dart';
import 'package:get/get.dart';

import '../data/model/response/base/api_response.dart';
import '../data/repository/booking_repo.dart';
import '../helper/api_checker.dart';
import '../helper/enum_data.dart';
import 'bookings_controller.dart';

class CalendarController extends GetxController {
  final BookingRepo bookingsRepo = BookingRepo.instance;
  late Month selectedMonth;
  late int selectedYear;
  late List<int> availableYears;

  // List<String> bookedDaysAtMonth = [];
  List<CalendarBookingModel> calendarBookings = [];
  bool isLoading = false;
  BookingModel? currentBookingModel;

  Future<bool> getBookingInfo(int bookingId) async {
    ApiResponse apiResponse = await bookingsRepo.getBookingInfo(bookingId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentBookingModel =
          BookingModel.fromJson(apiResponse.response!.data["data"]);
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }

    return false;
  }

  getCalendarBookings() async {
    final bookingController = Get.find<BookingsController>();
    if(bookingController.selectedChaletId == null) return null;
    calendarBookings = [];
    ApiResponse apiResponse = await bookingsRepo.getCalendarBookings(
        chaletId: bookingController.selectedChaletId!,
        year: selectedYear,
        month: (selectedMonth.index + 1),
        period: bookingController.selectedBookingPeriod.name);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      calendarBookings = (apiResponse.response!.data["data"] as List)
          .map((booking) => CalendarBookingModel.fromJson(booking))
          .toList();
      update();
      return true;
    } else {
      update();
      ApiChecker.checkApi(apiResponse);
    }

    return false;
  }

  Future<bool> getMyChaletsAndCalendarBookings() async {
    final bookingController = Get.find<BookingsController>();
    final bool result = await bookingController.getChaletIdWithName();
    if (result) {
      getCalendarBookings();
      return true;
    }
    return false;
  }

  CalendarController() {
    selectedMonth = Month.values[DateTime.now().month - 1];
    selectedYear = DateTime.now().year;
    final year = DateTime.now().year;
    availableYears = [year, year + 1];
  }

  // void getBookedDaysAtMonth() {
  //   bookedDaysAtMonth = [];
  //   for (final element in dummyBookings) {
  //     final List<String> info = element.split("-");
  //     if (info[1] == (selectedMonth.index + 1).toString() &&
  //         info[2] == selectedYear.toString() &&
  //         info[3] == selectedPeriod.toString()) {
  //       bookedDaysAtMonth.add(info[0]);
  //     }
  //   }
  // }

  void selectCalendarMonth(Month? month) {
    if (month == null) return;
    selectedMonth = month;
    getCalendarBookings();
  }

  void selectYear(int? year) {
    if (year == null) return;
    selectedYear = year;
    getCalendarBookings();
  }

  void changeSelectedChalet(int? chaletId) {
    final bookingController = Get.find<BookingsController>();
    bookingController.changeSelectedChalet(chaletId);
    getCalendarBookings();
  }
}
