import 'package:daif_owner/data/model/response/service_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/view/screens/my_places/widget/single_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({Key? key, required this.services}) : super(key: key);
  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            locale.services,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: services
                .map((service) => SingleServiceWidget(service: service))
                .toList(),
          ),
        )
      ],
    );
  }
}
