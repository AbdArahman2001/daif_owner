import 'dart:developer';

import 'package:daif_owner/data/model/response/service_model.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseServicesWidget extends StatelessWidget {
  const ChooseServicesWidget({Key? key, required this.allServices, required this.changeServiceStatus, required this.selectedServices})
      : super(key: key);
  final List<ServiceModel> allServices;
  final List<int> selectedServices;
  final void Function(int serviceId) changeServiceStatus;
  @override
  Widget build(BuildContext context) {
    log("services: $allServices");
    return Column(
      children: allServices
          .map((service) => _SingleServiceWidget(
              service: service,
              isSelected: selectedServices.contains(service.id),
          changeServiceStatus: changeServiceStatus))
          .toList(),
    );
  }
}

class _SingleServiceWidget extends StatelessWidget {
  const _SingleServiceWidget(
      {Key? key,
      required this.isSelected,
      required this.changeServiceStatus,
      required this.service})
      : super(key: key);
  final bool isSelected;
  final void Function(int serviceId) changeServiceStatus;
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorManager.complementaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
            value: isSelected,
            onChanged: (value) => changeServiceStatus(service.id)),
         SizedBox(width: 16.w,),
         Text(service.name,style: style_400_14(ColorManager.blackTextColor),),

      ],
    );
  }
}
