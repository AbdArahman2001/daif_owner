import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseServicesWidget extends StatelessWidget {
  const ChooseServicesWidget({Key? key, required this.services, required this.changeServiceValue})
      : super(key: key);
  final Map<String, bool> services;
  final void Function(String service,bool? value) changeServiceValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: services.keys
          .map((service) => _SingleServiceWidget(
              service: service,
              isSelected: services[service]!,
          changeServiceValue: changeServiceValue))
          .toList(),
    );
  }
}

class _SingleServiceWidget extends StatelessWidget {
  const _SingleServiceWidget(
      {Key? key,
      required this.isSelected,
      required this.changeServiceValue,
      required this.service})
      : super(key: key);
  final bool isSelected;
  final void Function(String service,bool? value) changeServiceValue;
  final String service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorManager.complementaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
            value: isSelected,
            onChanged: (value) => changeServiceValue(service,value)),
         SizedBox(width: 16.w,),
         Text(service,style: style_400_14(ColorManager.blackTextColor),),

      ],
    );
  }
}
