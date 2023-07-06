import 'dart:developer';

import 'package:get/get.dart';

import '../helper/enum_data.dart';

class CalendarController extends GetxController {
  CalendarController() {
    _selectedMonth = Month.values[DateTime
        .now()
        .month - 1];
    _selectedYear = DateTime
        .now()
        .year;
    final year = DateTime.now().year;
    _selectedPeriod = "a";
    _availableYears = [year,year+1];
    getBookedDaysAtMonth();
  }

  late Month _selectedMonth;

  Month get selectedMonth => _selectedMonth;
  late int _selectedYear;
  late String _selectedPeriod;
  String get selectedPeriod =>_selectedPeriod;
  int get selectedYear => _selectedYear;
  late List<int> _availableYears;
  List<int> get availableYears => _availableYears;
  // ["12-2-2023-a","13-4-2023-p",.....]

  List<String> bookedDaysAtMonth = [];


  void getBookedDaysAtMonth() {
    bookedDaysAtMonth = [];
    for (final element in dummyBookings) {
      final List<String> info = element.split("-");
      if (info[1] == (selectedMonth.index + 1).toString() &&
          info[2] == selectedYear.toString() &&
          info[3] == _selectedPeriod.toString()) {
        bookedDaysAtMonth.add(info[0]);
      }
    }
  }

  void changeDayStatus(String day) {
    final String input = "$day-${selectedMonth.index+1}";
    update();
  }

  void selectCalendarMonth(Month? month) {
    if (month == null) return;
    _selectedMonth = month;
    getBookedDaysAtMonth();
    update();
  }

  void selectYear(int? year) {
    if (year == null) return;
    _selectedYear = year;
    getBookedDaysAtMonth();
    update();
  }
  void changeSelectedPeriod(String period){
    _selectedPeriod = period;
    getBookedDaysAtMonth();
    update();
  }

  final List<String> dummyBookings = [
    "12-6-2023-a",
    "13-6-2023-a",
    "28-6-2023-p",
    "18-6-2023-p",
    "20-3-2023-a",
    "1-7-2023-a",
    "5-12-2023-p",
    "25-1-2023-a",
    "29-2-2023-a",
    "3-3-2023-a",
    "12-3-2023-p",
  ];
}