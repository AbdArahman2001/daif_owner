import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:daif_owner/view/screens/my_places/screen/add_or_update_new_chalet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/chalet_widget.dart';

class ChaletsScreen extends StatelessWidget {
  const ChaletsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return GetBuilder<MyPlacesController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
          title: locale.places,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            controller.getAllAvailableServices();
            Get.toNamed(Routes.addNewChalet);
          },
        ),
        body: controller.myChalets != null && controller.myChalets!.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 164 / 195,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 10.w,
                    crossAxisCount: 2),
                itemCount: controller.myChalets!.length,
                itemBuilder: (context, index) {
                  return ChaletWidget(
                      chaletShortInfo: controller.myChalets![index]);
                })
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locale.you_do_not_have_chalets_yet,
                    style: style_600_14(ColorManager.blackTextColor),
                  ),
                  TextButton(
                      onPressed: () => Get.toNamed(Routes.addNewChalet),
                      child: Text(locale.add_first_chalet)),
                ],
              )),
      );
    });
  }
}
