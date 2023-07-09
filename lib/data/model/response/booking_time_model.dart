import 'package:daif_owner/helper/date_converter.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/cupertino.dart';

import '../../../utill/app_constants.dart';

enum BookingPeriod{
  evening,morning
}
extension BookingPeriodInfo on BookingPeriod{
  String translate(BuildContext context){
    final locale = MyLocalizations.translate(context);
    switch (this){
      case BookingPeriod.evening:
        return locale.evening;
      case BookingPeriod.morning:
        return locale.morning;
    }
  }
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

  factory BookingDateModel.fromDateTime(DateTime bookingDate){
    return BookingDateModel(year: bookingDate.year.toString(), month: bookingDate.month.toString(), day: bookingDate.day.toString());
  }

  String toStringInfo() {
    return [year, month, day].join("-");
  }

  String toFormattedTime() {
    return DateConverter.localDateToIsoString(DateTime(
        int.parse(year), int.parse(month), int.parse(day), bookingHour));
  }
}
