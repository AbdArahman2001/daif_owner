import 'package:cached_network_image/cached_network_image.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../full_screen_image.dart';

class ImageViewerDialog extends StatelessWidget {
  const ImageViewerDialog(
      {Key? key,
      required this.imagePath,
      required this.height,
      required this.width})
      : super(key: key);
  final String imagePath;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showImage(context);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Hero(
            tag: imagePath,
            child: CustomCachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imagePath,
              width: width,
              height: 200,
            ),
          )),
    );
  }

  void _showImage(BuildContext context) {
    Get.to(()=>FullScreenImage(imagePath: imagePath,));

  }
}

