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
  final int year; //"day-month-year-period" period: a:AM, p: PM
  final int month;
  final int day;

  BookingDateModel(
      {required this.year,
      required this.month,
      required this.day,});

  factory BookingDateModel.fromStringInfo(String strInfo) {
    final infoList = strInfo.split("-");
    return BookingDateModel(
        year: int.parse(infoList[2]),
        month: int.parse(infoList[1]),
        day:int.parse(infoList[0]),
        );
  }

  factory BookingDateModel.fromDateTime(DateTime bookingDate){
    return BookingDateModel(year: bookingDate.year, month: bookingDate.month, day: bookingDate.day);
  }

  String toStringInfo() {
    return [year, month, day].join("-");
  }


  DateTime toDateTime(){
    return DateTime(year,month,day);
  }
}
