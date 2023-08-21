import 'package:daif_owner/helper/network_info.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:daif_owner/view/basewidget/empty_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetScreen extends StatelessWidget {
  NoInternetScreen({super.key});
  bool isFirstTime = true;
  DateTime? lastDate;
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                SizedBox(height: 20.h,),

        Text(locale.no_internet_connection,style: style_500_16(ColorManager.blackTextColor
        ),),
        SizedBox(height: 40.h,),
        Expanded(child: Image.asset(ImageAssets.noInternetImg)),
        SizedBox(height: 40.h,),
        // CustomElevatedButton(onPressed: () =>NetworkInfo.checkConnectivity(), child: Text(locale.try_again)),
        
        SizedBox(height: 80.h,)
      ]),
    );
  }
}
