import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleOnBoardingView extends StatefulWidget {
  const SingleOnBoardingView(
      {Key? key,
      required this.title,
      required this.imgUrl})
      : super(key: key);
  final String title;
  final String imgUrl;

  @override
  _SingleOnBoardingViewState createState() => _SingleOnBoardingViewState();
}

class _SingleOnBoardingViewState extends State<SingleOnBoardingView> {
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              widget.title,
              style: style_400_18(ColorManager.blackTextColor),
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.r),
                  topLeft: Radius.circular(40.r)),
              child: Container(
                height: 550.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.r),
                          topLeft: Radius.circular(40.r))),
                  child: Image.asset(
                    widget.imgUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
