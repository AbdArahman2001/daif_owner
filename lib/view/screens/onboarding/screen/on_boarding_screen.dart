import 'package:daif_owner/controller/on_boarding_controller.dart';
import 'package:daif_owner/controller/profile_controller.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/utill/values_manager.dart';
import 'package:daif_owner/view/basewidget/empty_app_bar.dart';
import 'package:daif_owner/view/screens/onboarding/screen/single_on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utill/color_manager.dart';
import '../../../basewidget/button/custom_back_button.dart';
import '../../../basewidget/dialog/choose_language_dialog.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    final titles = [
      locale.first_on_boarding_title,
      locale.second_on_boarding_title,
      locale.third_on_boarding_title,
      locale.fourth_on_boarding_title,
    ];

    final images = [
      ImageAssets.onBoardingImg1,
      ImageAssets.onBoardingImg2,
      ImageAssets.onBoardingImg3,
      ImageAssets.onBoardingImg4,
    ];
    return GetBuilder<OnBoardingController>(
      builder: (controller){
        return Scaffold(
          appBar: const EmptyAppBar(),
          body: Stack(
            alignment: Alignment.bottomCenter,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomBackButton(
                              onPressed: controller.goPreviousPage,
                            ),
                            IconButton(onPressed: (){
                              final controller = Get.find<ProfileController>();
                              final dialog = ChooseLanguageDialog(
                                  languageGroup: controller.languageGroup,
                                  changeLanguage: controller.changeLanguage);
                              showDialog(
                                  context: context, builder: (context) => dialog);
                            }, icon: Icon(Icons.language))
                          ],
                        ),
                        TextButton(
                          onPressed:
                            controller.skip,
                          child: Text(locale.skip),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: controller.changePage,
                      children: images
                          .map((image) => SingleOnBoardingView(
                          title: titles[images.indexOf(image)],
                          imgUrl: image))
                          .toList(),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 45.h),
                child: ElevatedButton(
                  onPressed: () {
                    controller.controlNavigation(titles.length);
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(220.w, 60.h)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        controller.index == titles.length - 1 ? locale.login : locale.next,
                        style: style_500_16(ColorManager.whiteColor),
                      ),
                      SizedBox(
                        width: 42.w,
                        height: 42.w,
                        child: OutlinedButton(
                          onPressed: () {
                            controller.controlNavigation(titles.length);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: ColorManager.primaryGradient,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(ValuesManager.border),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

      },
    );
  }


}
