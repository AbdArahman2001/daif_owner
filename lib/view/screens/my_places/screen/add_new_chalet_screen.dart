import 'dart:io';

import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/screens/my_places/widget/add_place_images_widget.dart';
import 'package:daif_owner/view/screens/my_places/widget/choose_services_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/my_places_controller.dart';
import '../../../../helper/helper.dart';
import '../../../../localization/my_localizations.dart';
import '../../../basewidget/custom_app_bar.dart';

class AddNewChaletScreen extends StatelessWidget {
  const AddNewChaletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: locale.new_chalet,
        actions: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<MyPlacesController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  locale.chalet_pictures,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AddPlaceImagesWidget(
                    removeImg: controller.removeImage,
                    maxImagesNumber: 6,
                    dimensions: 70.w,
                    pickMultiImage: controller.pickMultiImage,
                    pickedImages: controller.pickedImages),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.place_name,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.placeNameController,
                  decoration: InputDecoration(hintText: locale.place_name),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.governorate,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ColorManager.whiteColor),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: DropdownButton<Governorate>(
                      underline: SizedBox(),
                      isExpanded: true,
                      icon: Icon(Icons.expand_more),
                      value: controller.selectedGovernorate,
                      items: Governorate.values
                          .map((e) => DropdownMenuItem<Governorate>(
                              value: e, child: Text(e.getName(context))))
                          .toList(),
                      onChanged: controller.setGovernorate),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.address,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.addressController,
                  decoration: InputDecoration(hintText: locale.address),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.evening_price,
                            style: style_400_16(ColorManager.blackTextColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            controller: controller.eveningPriceController,
                            decoration: const InputDecoration(hintText: "500"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.morning_price,
                            style: style_400_16(ColorManager.blackTextColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            controller: controller.morningPriceController,
                            decoration: const InputDecoration(hintText: "600"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.services,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                ChooseServicesWidget(
                  allServices: controller.allAvailableServices,
                  changeServiceStatus: controller.changeServiceStatus,
                  selectedServices: controller.selectedServicesIds,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  locale.description,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 7,
                  decoration:
                      InputDecoration(hintText: locale.type_description),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.pool_dimensions,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.pollLengthController,
                        decoration: InputDecoration(hintText: locale.length),
                      ),
                    ),
                    SizedBox(
                      width: 24.h,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.pollWidthController,
                        decoration: InputDecoration(hintText: locale.width),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.pollMinHeightController,
                        decoration:
                            InputDecoration(hintText: locale.min_height),
                      ),
                    ),
                    SizedBox(
                      width: 24.h,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.pollMinWidthController,
                        decoration:
                            InputDecoration(hintText: locale.max_height),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.video_link,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.videoLinkController,
                  decoration: const InputDecoration(
                      hintText: "https://www.youtube.com"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  locale.license_picture,
                  style: style_400_16(ColorManager.blackTextColor),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: SizedBox(
                    width: 320.w,
                    height: 160.w,
                    child: DottedBorder(
                      radius: Radius.circular(12.r),
                      color: ColorManager.grey1,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      dashPattern: <double>[5, 5],
                      child: Center(
                          child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          controller.licenceImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    File(controller.licenceImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                            ),
                            onPressed: () => Helper.openImageSourceDialog(
                                context, controller.pickLicenceImage),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomElevatedButton(
                    onPressed: controller.createChaletWithAttachments,
                    child: Text(locale.save)),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
