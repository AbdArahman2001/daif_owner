import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child:Hero(
          tag: imagePath,
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(
              imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
