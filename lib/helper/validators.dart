import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

class Validators {
  static String? lengthValidator(String? input, String message) {
    if (input != null && input.length > 6) {
      return null;
    }
    return message;
  }

  static String? intValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    if (input != null && isInt(input)) {
      return null;
    }
    return locale.enter_valid_number;
  }

  static String? numValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    if (input != null && isNumeric(input)) {
      return null;
    }
    return locale.enter_numeric_value;
  }

  static String? identityNumberValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    if (input != null && input.length == 9) {
      return null;
    }
    return locale.identity_number_length_must_be_9_numbers;
  }

  static String? passwordValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    if (input != null && input.length >= 8) {
      return null;
    }
    return locale.password_must_be_more_8;
  }

  static String? phoneNumberValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    if (input != null &&
        (input.startsWith("056") || input.startsWith("059")) &&
        input.length == 10) {
      return null;
    }

    return locale.enter_valid_phone_number;
  }

  static String? emailValidator(String? input, BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final result = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input ?? "");

    return result ? null : locale.enter_valid_email;
  }
}
