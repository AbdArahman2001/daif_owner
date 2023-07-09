import 'dart:io';

import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../helper/helper.dart';

class AddPlaceImagesWidget extends StatelessWidget {
  const AddPlaceImagesWidget(
      {Key? key,
      required this.removeImg,
      required this.maxImagesNumber,
      required this.dimensions,
      required this.pickMultiImage,
      required this.pickedImages})
      : super(key: key);
  final List<XFile> pickedImages;
  final void Function(int index) removeImg;
  final int maxImagesNumber;
  final double dimensions;
  final Function(ImageSource source) pickMultiImage;

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...pickedImages.map((e) {
            index++;
            return _SinglePlaceImg(
              isFromNetwork: false,
              imageUrl: e.path,
              imageIndex: index,
              removeImg: removeImg,
              dimensions: dimensions,
            );
          }),
          SizedBox(
            width: 3.w,
          ),
          Visibility(
            visible: pickedImages.length < maxImagesNumber,
            child: SizedBox(
              width: dimensions,
              height: dimensions,
              child: DottedBorder(
                radius: Radius.circular(12.r),
                color: ColorManager.grey1,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                dashPattern: const <double>[5, 5],
                child: Center(
                    child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      Helper.openImageSourceDialog(context,pickMultiImage),
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
  }
}

class _SinglePlaceImg extends StatelessWidget {
  const _SinglePlaceImg(
      {Key? key,
      required this.isFromNetwork,
      required this.imageUrl,
      required this.removeImg,
      required this.imageIndex, required this.dimensions})
      : super(key: key);
  final bool isFromNetwork;
  final String imageUrl;
  final int imageIndex;
  final double dimensions;
  final void Function(int index) removeImg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: dimensions,
          height: dimensions,
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
          onPressed: () => removeImg(imageIndex),
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
