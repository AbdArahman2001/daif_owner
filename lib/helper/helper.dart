import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';
class Helper {

  static int getImageQuality(ImageSource source){
     return source == ImageSource.camera?50:70;
  }
  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager() .getSingleFile(url);
    XFile result =  XFile(file.path);
    return result;
  }

  static Governorate getGovernorateFromId(int id){
    switch(id){
      case 1:
        return Governorate.north;
      case 2:
        return Governorate.north;
      case 3:
        return Governorate.north;
      case 4:
        return Governorate.north;
      case 5:
        return Governorate.north;
      default:
        return Governorate.gaza;
    }
  }

  static getDayNameFromDate(DateTime firstDate, int dayIndex,BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final int day = ((firstDate.weekday + dayIndex - 1) % 7);
    switch (day) {
      case 1:
        return locale.monday;
      case 2:
        return locale.tuesday;
      case 3:
        return locale.wednesday;
      case 4:
        return locale.thursday;
      case 5:
        return locale.friday;
      case 6:
        return locale.saturday;
      case 0:
        return locale.sunday;
      default:
        return "UnKnown";
    }
  }

  static void doLaunchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
     CustomSnackBar.instance.showCustomErrorToast(message: "Couldn't Launch URL");
    }
  }


  static openImageSourceDialog(BuildContext context, Function pickImg) async {
    final locale = MyLocalizations.translate(context);
    final AlertDialog dialog = AlertDialog(
      title: Text(locale.attach_image),
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

extension TokenTypeInfo on TokenType{
  static TokenType? getTokenTypeFromName(String? name){
    if(name == TokenType.login.name) return TokenType.login;
    if(name == TokenType.register.name) return TokenType.register;
    return null;
  }
}
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
