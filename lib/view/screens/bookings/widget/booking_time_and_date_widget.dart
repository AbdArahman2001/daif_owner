import 'package:flutter/material.dart';

import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
class BookingTimeAndDateWidget extends StatelessWidget {
  const BookingTimeAndDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      "Sat, 08-Oct-22, 12:00 PM",
      style:
      style_400_13(ColorManager.blackTextColor.withOpacity(0.8)),
    );
  }
}
