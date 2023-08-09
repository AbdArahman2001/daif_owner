import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daif_owner/view/screens/my_places/widget/single_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/color_manager.dart';
import '../../../basewidget/full_screen_image.dart';
import '../../../basewidget/indicator_circle_widget.dart';

class PlaceImagesWidget extends StatefulWidget {
  const PlaceImagesWidget({
    Key? key,
    required this.aspectRatio,
    required this.onTap,
    required this.imageWidth,
    required this.horizontalMargin,
    required this.viewportFraction,
    required this.enlargeCenterPage,
    required this.images,
    required this.imageHeight,
  }) : super(key: key);
  final double aspectRatio;
  final VoidCallback onTap;
  final double imageWidth;
  final double imageHeight;
  final double horizontalMargin;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final List<String> images;

  @override
  State<PlaceImagesWidget> createState() => _PlaceImagesWidgetState();
}

class _PlaceImagesWidgetState extends State<PlaceImagesWidget> {
  int currentIndex = 0;
  final indicatorWidth = 100;
  late final int imagesLength;

  @override
  void initState() {
    super.initState();
    imagesLength = widget.images.isNotEmpty ? widget.images.length : 1;

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images
              .map((image) => SingleSliderWidget(
            imagePath: image,
            borderRadius: 40.r,
            imageHeight: widget.imageHeight,
            onTap: () =>  Get.to(()=>FullScreenImage(imagePath: image,)),
            imageWidth: widget.imageWidth,
            horizontalMargin: widget.horizontalMargin,
          ))
              .toList(),
          options: CarouselOptions(
              aspectRatio: widget.aspectRatio,
              viewportFraction: widget.viewportFraction,
              autoPlay: true,
              padEnds: true,
              enlargeCenterPage: widget.enlargeCenterPage,
              onPageChanged: (index, _) {
                currentIndex = index;
                setState(() {});
              }),
        ),
        Positioned(
          left: ((MediaQuery.of(context).size.width - (indicatorWidth.w)) / 2),
          top: MediaQuery.of(context).size.height * .35,
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            width: indicatorWidth.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
        Positioned(
          left: currentIndex * (indicatorWidth.w / imagesLength) +
              ((MediaQuery.of(context).size.width - (indicatorWidth.w)) / 2),
          top: MediaQuery.of(context).size.height * .35,
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            width: indicatorWidth.w / imagesLength,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
