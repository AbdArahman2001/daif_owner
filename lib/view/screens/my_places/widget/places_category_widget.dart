import 'package:cached_network_image/cached_network_image.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
// import 'package:daif_owner/view/screens/my_places/screen/chalets_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../screen/chalets_screens.dart';

class PlacesCategoryWidget extends StatelessWidget {
  const PlacesCategoryWidget({Key? key, required this.imageUrl, required this.title})
      : super(key: key);
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.to(const ChaletsScreen()),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(16.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 115.h,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.white,letterSpacing: 2)
          )
        ],
      ),
    );
  }
}
