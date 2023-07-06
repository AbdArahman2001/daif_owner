import 'dart:io';

import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddPlaceImagesWidget extends StatelessWidget {
  const AddPlaceImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return GetBuilder<MyPlacesController>(
        builder: (controller) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...controller.pickedImages.map((e) {
                  index++;
                  return _SinglePlaceImg(
                    isFromNetwork: false,
                    imageUrl: e.path,
                    imageIndex: index,
                    removeImg: controller.removeImage,
                  );
                }),
                SizedBox(
                  width: 3.w,
                ),
                Visibility(
                  visible: controller.pickedImages.length < 6,
                  child: SizedBox(
                    width: 70.w,
                    height: 70.w,
                    child: DottedBorder(
                      radius: Radius.circular(12.r),
                      color: ColorManager.grey1,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      dashPattern: <double>[5, 5],
                      child: Center(
                          child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: controller.pickMultiImage,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                )
              ],
            ),
          );
        });
  }
}

class _SinglePlaceImg extends StatelessWidget {
  const _SinglePlaceImg(
      {Key? key,
      required this.isFromNetwork,
      required this.imageUrl,
      required this.removeImg, required this.imageIndex})
      : super(key: key);
  final bool isFromNetwork;
  final String imageUrl;
  final int imageIndex;
  final void Function(int index) removeImg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: isFromNetwork
                ? CustomCachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 70.w,
                    height: 70.w,
                  )
                : Image.file(
                    File(imageUrl),
                    fit: BoxFit.cover,
                    width: 70.w,
                    height: 70.w,
                  ),
          ),
        ),
        IconButton(
          onPressed: ()=>removeImg(imageIndex),
          icon: Icon(
            Icons.cancel,
            color: ColorManager.errorColor.withOpacity(0.5),
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
