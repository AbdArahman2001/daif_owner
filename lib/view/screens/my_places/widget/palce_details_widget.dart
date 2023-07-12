import 'package:daif_owner/view/screens/my_places/widget/place_services_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/chalet_model.dart';
import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../bookings/widget/custom_divider_widget.dart';

class PlaceDetailsWidget extends StatelessWidget {
  const PlaceDetailsWidget(
      {Key? key, required this.chalet})
      : super(key: key);
  final ChaletModel chalet;
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
             chalet.description ,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

          ]),
        ),
        SizedBox(
          height: 20.h,
        ),
        ServicesWidget(services: chalet.services),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }
}