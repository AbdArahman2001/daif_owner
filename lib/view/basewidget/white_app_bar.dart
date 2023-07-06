import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/color_manager.dart';
class WhiteAppBar extends StatelessWidget implements PreferredSizeWidget{
  const WhiteAppBar({Key? key,  this.title}) : super(key: key);
final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 60.h,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: ColorManager.backgroundColor,
      title:Text(title??"",style: style_500_16(ColorManager.blackTextColor),) ,
      centerTitle: true,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 12.w,),
          const CustomBackButton(),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 70.h);
}
