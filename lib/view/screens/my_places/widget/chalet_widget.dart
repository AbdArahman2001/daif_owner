import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../basewidget/custom_cached_network_image.dart';
import '../screen/place_details_screen.dart';
class ChaletWidget extends StatelessWidget {
   ChaletWidget({Key? key,required this.chaletShortInfo}) : super(key: key);
final ChaletShortInfo chaletShortInfo;
final controller = Get.find<MyPlacesController>();
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        Get.to(const PlaceDetailsScreen());
        controller.getChaletInfoAndAttachments(chaletShortInfo.id);

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CustomCachedNetworkImage(
                imageUrl: chaletShortInfo.image.path,
                height: 150.h,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    chaletShortInfo.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.place,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  chaletShortInfo.address.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  width: 8.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
