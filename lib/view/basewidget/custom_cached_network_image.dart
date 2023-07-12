import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utill/assets_manager.dart';
class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({Key? key, required this.imageUrl,  this.height,  this.width,}) : super(key: key);
  final String imageUrl;
final double? height;
final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      placeholder: (_, __) =>
          Image.asset(ImageAssets.placeHolderImg,fit: BoxFit.cover,width: width,height: height,),
      errorWidget: (_, __, ___) =>
          Image.asset(ImageAssets.placeHolderImg,fit: BoxFit.cover,width: width,height: height,),
    );
  }
}
