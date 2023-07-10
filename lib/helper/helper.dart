import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  static getDayNameFromDate(DateTime firstDate, int dayIndex) {
    final int day = ((firstDate.weekday + dayIndex - 1) % 7);
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 0:
        return "Sunday";
      default:
        return "UnKnown";
    }
  }

  static navigateToCallingBoard() {
    // TODO Implement it
  }

  static openImageSourceDialog(BuildContext context, Function pickImg) async {
    final locale = MyLocalizations.translate(context);
    final AlertDialog dialog = AlertDialog(
      title: Text(locale.attack_image),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: const Icon(Icons.photo),
              onTap: () {
                Get.back();
                pickImg(ImageSource.gallery);
              },
              title: Text(locale.from_gallery)),
          ListTile(
              leading: const Icon(Icons.photo_camera),
              onTap: () {
                Get.back();
                pickImg(ImageSource.camera);
              },
              title: Text(locale.open_camera)),
        ],
      ),
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}

enum WeekDays { sat, sun, mon, tue, wed, thu, fri }

enum TokenType { register, login }

enum Governorate { north, gaza, middleGaza, khanYounes, rafah }

extension GovernorateExt on Governorate {
  String getName(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    switch (this) {
      case Governorate.north:
        return locale.north_gaza;
      case Governorate.gaza:
        return locale.gaza;
      case Governorate.middleGaza:
        return locale.middle_gaza;
      case Governorate.khanYounes:
        return locale.khan_younes;
      case Governorate.rafah:
        return locale.rafah;
    }
  }
}
