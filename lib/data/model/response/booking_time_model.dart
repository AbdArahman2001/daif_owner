import 'package:daif_owner/helper/date_converter.dart';

import '../../../utill/app_constants.dart';

class BookingTimeModel {
  final String year; //"day-month-year-period" period: a:AM, p: PM
  final String month;
  final String day;
  final String period;

  BookingTimeModel(
      {required this.year,
      required this.month,
      required this.day,
      required this.period});

  factory BookingTimeModel.fromStringInfo(String strInfo) {
    final infoList = strInfo.split("-");
    return BookingTimeModel(
        year: infoList[2],
        month: infoList[1],
        day: infoList[0],
        period: infoList[3]);
  }

  String toStringInfo() {
    return [day, month, year, period].join("-");
  }

  String toFormattedTime() {
    return DateConverter.localDateToIsoString(DateTime(
        int.parse(year), int.parse(month), int.parse(day), bookingHour));
  }
}
