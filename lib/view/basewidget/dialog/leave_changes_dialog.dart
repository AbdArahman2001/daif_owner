import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LeaveChangesDialog extends StatelessWidget {
  const LeaveChangesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text("Are you sure to exit? changes will discarded" ),
      actions: [
        TextButton(onPressed: ()=>Get.back(result: true), child: Text("discard")),
        TextButton(onPressed:()=>Get.back(result: false), child: Text("stay")),
      ],
    );
  }
}
