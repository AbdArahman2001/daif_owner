import 'package:daif_owner/localization/my_localizations.dart';
import 'package:flutter/cupertino.dart';

class DataConverter {

static String key2NameService(BuildContext context,String key){
  final locale = MyLocalizations.translate(context);
  switch(key){
    case "restaurant":
      return locale.restaurant;
    case "parking":
      return locale.parking;
    case "table_tennis":
      return locale.table_tennis;
    case "football":
      return locale.football;
    case "play_station":
      return locale.play_station;
    case "swimming_bool":
      return locale.swimming_bool;
    case "free_wifi":
      return locale.free_wifi;
    default: return key;
  }
}
}


