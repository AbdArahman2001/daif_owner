import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
class BookingIDWidget extends StatelessWidget {
  const BookingIDWidget({Key? key, required this.id}) : super(key: key);
final String id;
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Text(
      "${locale.booking} #$id",
      style: style_600_15(ColorManager.blackTextColor),
      textAlign: TextAlign.start,
    );
  }
}
