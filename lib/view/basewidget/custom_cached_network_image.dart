import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utill/assets_manager.dart';
class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({Key? key, required this.imageUrl,  this.height,  this.width, this.imageId}) : super(key: key);
  final String imageUrl;
final double? height;
final double? width;
final String? imageId;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageId??UniqueKey(),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        placeholder: (_, __) =>
            Image.asset(ImageAssets.placeHolderImg,fit: BoxFit.cover,),
        errorWidget: (_, __, ___) =>
            Image.asset(ImageAssets.placeHolderImg,fit: BoxFit.cover,),
      ),
    );
  }
}
