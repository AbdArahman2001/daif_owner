import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CancelBookingDialog extends StatelessWidget {
  const CancelBookingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return AlertDialog(
      content:Text("sure_to_cancel_booking") ,
      actions: [
        TextButton(onPressed:()=>Get.back(result: true) , child: Text("confirm")),
        TextButton(onPressed: ()=>Get.back(result: false), child: Text("discard")),
      ],
    );
  }
}
