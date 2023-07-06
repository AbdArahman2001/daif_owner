import 'package:flutter/material.dart';

import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
class BookingTimeAndDateWidget extends StatelessWidget {
  const BookingTimeAndDateWidget({Key? key, required this.bookingDate}) : super(key: key);
final String bookingDate;
  @override
  Widget build(BuildContext context) {
    return  Text(
      bookingDate,
      style:
      style_400_13(ColorManager.blackTextColor.withOpacity(0.8)),
    );
  }
}
