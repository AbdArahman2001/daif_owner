
import 'package:flutter/material.dart';

import '../localization/my_localizations.dart';
enum LanguageType { arabic, english }

extension LanguageInfo on LanguageType {
  String getLanguageName(BuildContext context) {
    final local = MyLocalizations.translate(context);
    switch (this) {
      case LanguageType.arabic:
        return local.arabic;
      case LanguageType.english:
        return local.english;
    }
  }

  String getLanguageCode() {
    switch (this) {
      case LanguageType.arabic:
        return "ar";
      case LanguageType.english:
        return "en";
    }
  }
}



enum Month { jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec }

extension MonthExt on Month {
  String month2Name(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    switch (this) {
      case Month.jan:
        return locale.january;
      case Month.feb:
        return locale.february;

      case Month.mar:
        return locale.march;

      case Month.apr:
        return locale.april;

      case Month.may:
        return locale.may;

      case Month.jun:
        return locale.jun;

      case Month.jul:
        return locale.july;

      case Month.aug:
        return locale.august;

      case Month.sep:
        return locale.september;

      case Month.oct:
        return locale.october;

      case Month.nov:
        return locale.november;

      case Month.dec:
        return locale.december;
    }
  }

  int getDaysCount(int year) {
    switch (this) {
      case Month.jan:
        return 31;
      case Month.feb:
        final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
        return isLeapYear ? 29 : 28;
      case Month.mar:
        return 31;

      case Month.apr:
        return 30;

      case Month.may:
        return 31;

      case Month.jun:
        return 30;

      case Month.jul:
        return 31;

      case Month.aug:
        return 31;

      case Month.sep:
        return 30;

      case Month.oct:
        return 31;

      case Month.nov:
        return 30;

      case Month.dec:
        return 31;
    }
  }
}