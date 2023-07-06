import 'package:daif_owner/helper/date_converter.dart';

import '../../../utill/app_constants.dart';

enum BookingPeriod{
  evening,morning
}

class BookingDateModel {
  final String year; //"day-month-year-period" period: a:AM, p: PM
  final String month;
  final String day;

  BookingDateModel(
      {required this.year,
      required this.month,
      required this.day,});

  factory BookingDateModel.fromStringInfo(String strInfo) {
    final infoList = strInfo.split("-");
    return BookingDateModel(
        year: infoList[2],
        month: infoList[1],
        day: infoList[0],
        );
  }

  String toStringInfo() {
    return [year, month, day].join("-");
  }

  String toFormattedTime() {
    return DateConverter.localDateToIsoString(DateTime(
        int.parse(year), int.parse(month), int.parse(day), bookingHour));
  }
}
