import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthMethodTabButton extends StatelessWidget {
  const AuthMethodTabButton(
      {Key? key, required this.title, required this.isSelected})
      : super(key: key);
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: isSelected
              ? style_600_16(Theme.of(context).primaryColor)
              : style_400_16(ColorManager.blackTextColor),
        ),
        SizedBox(
          height: 6.h,
        ),
        Visibility(
          visible: isSelected,
          child: Container(
            width: 36.w,
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
