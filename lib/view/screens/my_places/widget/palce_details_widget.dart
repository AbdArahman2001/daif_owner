import 'package:daif_owner/view/screens/my_places/widget/place_services_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/chalet_model.dart';
import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../bookings/widget/custom_divider_widget.dart';

class PlaceDetailsWidget extends StatelessWidget {
  const PlaceDetailsWidget(
      {Key? key, required this.place, required this.dummyDetails, required this.services})
      : super(key: key);
  final ChaletModel place;
  final String dummyDetails;
final List<String> services;
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomDividerWidget(),
            SizedBox(
              height: 20.h,
            ),
            Text(
              dummyDetails,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  "2 ${locale.person}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorManager.blackTextColor),
                ),

              ],
            ),

          ]),
        ),
        SizedBox(
          height: 20.h,
        ),
        ServicesWidget(services: services),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }
}