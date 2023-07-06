import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/basewidget/empty_app_bar.dart';
import 'package:daif_owner/view/screens/bookings/widget/custom_divider_widget.dart';
import 'package:daif_owner/view/screens/my_places/widget/palce_details_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/my_places_controller.dart';
import '../../../../utill/color_manager.dart';
import '../widget/place_details_header_widget.dart';
import '../widget/place_images_widget.dart';
import '../widget/place_services_widget.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: const EmptyAppBar(
          height: 0,
        ),
        body: GetBuilder<MyPlacesController>(
          builder: (controller) {
            return controller.currentChaletAttachments != null &&
                    controller.currentChalet != null
                ? Column(
                    children: [
                      PlaceDetailsHeaderWidget(
                        chalet: controller.currentChalet!,
                        attachments: controller.currentChaletAttachments!,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              _TabBarWidget(
                                changeTab:
                                    controller.setSelectedDetailsTabIndex,
                                selectedIndex:
                                    controller.getSelectedDetailsTabIndex,
                              ),
                              PlaceDetailsWidget(
                                place: controller.currentChalet!,
                                dummyDetails: controller.dummyDetails,
                                services: controller.placeServices,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      );

  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget(
      {Key? key, required this.changeTab, required this.selectedIndex})
      : super(key: key);
  final void Function(int index) changeTab;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Row(
      children: [
        _SingleTabBarWidget(
            changeTab: () => changeTab(0),
            text: locale.details,
            isSelected: selectedIndex == 0),
        _SingleTabBarWidget(
            changeTab: () => changeTab(1),
            text: locale.statistics,
            isSelected: selectedIndex == 1),
      ],
    );
  }
}

class _SingleTabBarWidget extends StatelessWidget {
  const _SingleTabBarWidget(
      {Key? key,
      required this.changeTab,
      required this.text,
      required this.isSelected})
      : super(key: key);
  final VoidCallback changeTab;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: changeTab,
        child: Text(
          text,
          style: isSelected
              ? style_500_14(Theme.of(context).primaryColor)
                  .copyWith(decoration: TextDecoration.underline)
              : style_400_14(ColorManager.blackTextColor),
        ));
  }
}
