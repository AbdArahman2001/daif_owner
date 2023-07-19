import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/screens/my_places/widget/place_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/color_manager.dart';

class PlaceDetailsHeaderWidget extends StatelessWidget {
  const PlaceDetailsHeaderWidget(
      {Key? key, required this.chalet, required this.attachments})
      : super(key: key);
  final ChaletModel chalet;
  final List<AttachmentModel> attachments;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return SizedBox(
      height: 410.h,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 360.h,
              width: 360.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: PlaceImagesWidget(
                  images:
                      attachments.map((attachment) => attachment.path).toList(),
                  aspectRatio: 1.3,
                  onTap: () {},
                  imageWidth: 360.w,
                  imageHeight: 360.h,
                  horizontalMargin: 8.w,
                  viewportFraction: 1,
                  enlargeCenterPage: false),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                    const Expanded(child: SizedBox()),
                    TextButton.icon(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          final controller = Get.find<MyPlacesController>();
                          controller.setFieldsWithData();
                          Get.toNamed(Routes.updateChalet);
                        },
                        label: Text(locale.edit,
                            style: style_500_18(ColorManager.blackTextColor))),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                width: 326.w,
                height: 70.w,
                // padding: EdgeInsets.symmetric(vertical: 14.h,horizontal: 14.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Theme.of(context).dialogBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chalet.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.place,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              chalet.address.name,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              chalet.price.morning.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              " /${locale.morning}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              chalet.price.evening.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              " /${locale.evening}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
