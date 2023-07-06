import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utill/assets_manager.dart';



class SingleSliderWidget extends StatelessWidget {
  const SingleSliderWidget({
    Key? key,
    required this.imagePath,
    required this.onTap, required this.imageWidth, required this.horizontalMargin, this.imageHeight, this.borderRadius,
  }) : super(key: key);
  final String imagePath;
  final VoidCallback onTap;
  final double imageWidth;
  final double horizontalMargin;
  final double? imageHeight;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius??16.r),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              placeholder: (context, _) =>const PlaceHolderWidget(),
              errorWidget: (context,_,s)=>const PlaceHolderWidget(),
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Image.asset(
      ImageAssets.placeHolderImg,
      fit: BoxFit.fill,
    );
  }
}
