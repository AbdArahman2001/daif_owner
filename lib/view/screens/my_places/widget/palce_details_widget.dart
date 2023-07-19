import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:daif_owner/view/screens/my_places/widget/place_services_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/chalet_model.dart';
import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
import '../../bookings/widget/custom_divider_widget.dart';

class PlaceDetailsWidget extends StatelessWidget {
  const PlaceDetailsWidget(
      {Key? key, required this.chalet, required this.licenceImg})
      : super(key: key);
  final ChaletModel chalet;
  final AttachmentModel? licenceImg;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              chalet.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ]),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        ServicesWidget(services: chalet.services),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            locale.pool_dimensions,
            style: style_400_16(ColorManager.blackTextColor),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${locale.length}:   ",
                        style: style_400_16(ColorManager.blackTextColor),
                      ),
                      Text(
                        chalet.poolDimensions.length.toString(),
                        style: style_400_16(Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${locale.max_depth}:   ",
                        style: style_400_16(ColorManager.blackTextColor),
                      ),
                      Text(
                        chalet.poolDimensions.maxDepth.toString(),
                        style: style_400_16(Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${locale.width}:   ",
                        style: style_400_16(ColorManager.blackTextColor),
                      ),
                      Text(
                        chalet.poolDimensions.width.toString(),
                        style: style_500_16(Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${locale.min_depth}:   ",
                        style: style_400_16(ColorManager.blackTextColor),
                      ),
                      Text(
                        chalet.poolDimensions.minDepth.toString(),
                        style: style_500_16(Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            locale.video_link,
            style: style_400_16(ColorManager.blackTextColor),
          ),
        ),
        Center(
            child: chalet.videoLink.isNotEmpty
                ? TextButton(
                    onPressed:()=> Helper.doLaunchURL(chalet.videoLink),
                    child: Text(
                      chalet.videoLink,
                      style: style_500_16(Theme.of(context).primaryColor),
                    ))
                : Text(
                    "no video link",
                    style: style_400_16(Theme.of(context).primaryColor),
                  )),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            locale.license_picture,
            style: style_400_16(ColorManager.blackTextColor),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        licenceImg != null
            ? Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CustomCachedNetworkImage(
                  imageUrl: licenceImg!.path,
                  width: MediaQuery.of(context).size.width * .9,
                    height: 250.h,
              ),
                ))
            : Center(
                child: Text(
                "no licence Image",
                style: style_400_16(Theme.of(context).primaryColor),
              )),
        SizedBox(
          height: 50.h,
        ),
      ],
    );
  }
}
