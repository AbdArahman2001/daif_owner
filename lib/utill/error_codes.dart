import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ErrorCodes {
  auth_001,
  auth_002,
  auth_003,
  auth_004,
  auth_006,
  auth_007,
  auth_008,
  auth_009,
  general_001,
  general_003,
  general_004,
  general_005,
  booking_001,
  booking_002,
  unKnown
}

extension ErrorCodesInfo on ErrorCodes{

static  ErrorCodes stringToErrorCode(String code){
    switch(code){
      case "auth_001":
        return ErrorCodes.auth_001;
      case "auth_002":
        return ErrorCodes.auth_002;
      case "auth_003":
        return ErrorCodes.auth_003;
      case "auth_004":
        return ErrorCodes.auth_004;
      case "auth_006":
        return ErrorCodes.auth_006;
      case "auth_007":
        return ErrorCodes.auth_007;
      case "auth_008":
        return ErrorCodes.auth_008;
      case "auth_009":
        return ErrorCodes.auth_009;
      case "general_001":
        return ErrorCodes.general_001;
      case "general_003":
        return ErrorCodes.general_003;
      case "general_004":
        return ErrorCodes.general_004;
      case "general_005":
        return ErrorCodes.general_005;
      case "booking_001":
        return ErrorCodes.booking_001;
      case "booking_002":
        return ErrorCodes.booking_002;
      default:
        return ErrorCodes.unKnown;

    }
  }
  String getErrorMessage(String? message,BuildContext context){
    final locale = MyLocalizations.translate(context);
    switch(this){

      case ErrorCodes.auth_001:
       return locale.user_name_or_password_wrong;
      case ErrorCodes.auth_002:
        return locale.account_under_revision;
      case ErrorCodes.auth_003:
        return locale.account_temporary_suspend;
      case ErrorCodes.auth_004:
        return locale.account_terminated;
      case ErrorCodes.auth_006:
        return locale.used_phone_number;
      case ErrorCodes.auth_007:
        return locale.wrong_otp;
      case ErrorCodes.auth_008:
        return locale.account_already_verified;
      case ErrorCodes.auth_009:
        return locale.invalid_email;
      case ErrorCodes.general_001:
        return locale.system_developing;
      case ErrorCodes.general_003:
        return locale.too_much_attachments;
      case ErrorCodes.general_004:
        return locale.validation_errors;
      case ErrorCodes.general_005:
        return locale.access_denied;
      case ErrorCodes.booking_001:
        return locale.status_not_zero;
      case ErrorCodes.booking_002:
        return locale.two_bookings_at_same_time;
      case ErrorCodes.unKnown:

        return message??"Unknown";
    }
  }
}