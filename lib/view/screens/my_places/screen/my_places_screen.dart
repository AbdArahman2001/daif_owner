
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/my_places_controller.dart';
import '../../../../localization/my_localizations.dart';
import '../../../basewidget/custom_app_bar.dart';
import '../widget/places_category_widget.dart';
// Not used yet
class MyPlacesScreen extends StatelessWidget {
  const MyPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
     final List<String> categoriesName = [
      // locale.apartments,
      // locale.hotels,
      // locale.stadiums,
       locale.chalets,
      // locale.offices,
     ];
    return Scaffold(
      appBar: CustomAppBar(title: locale.places),
      body: GetBuilder<MyPlacesController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                ...controller.myPlacesCategoriesImages
                    .map((image) => PlacesCategoryWidget(
                        imageUrl: image, title: categoriesName[controller.myPlacesCategoriesImages.indexOf(image)]))
                    .toList(),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
