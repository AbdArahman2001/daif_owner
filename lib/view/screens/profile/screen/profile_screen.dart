import 'package:daif_owner/controller/profile_controller.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/main.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/custom_app_bar.dart';
import 'package:daif_owner/view/basewidget/custom_cached_network_image.dart';
import 'package:daif_owner/view/basewidget/dialog/choose_language_dialog.dart';
import 'package:daif_owner/view/screens/bookings/widget/custom_divider_widget.dart';
import 'package:daif_owner/view/screens/profile/widget/change_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/enum_data.dart';
import '../widget/language_type_list_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: locale.profile,
        actions: [SizedBox()],
        leading: SizedBox(),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(color: Theme
                            .of(context)
                            .primaryColor)),
                    height: 130.h,
                    width: 130.h,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: CustomCachedNetworkImage(
                            imageUrl: userInfo!.image)),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                _SingleInformationWidget(
                    title: locale.full_name, value: userInfo!.fullName),
                _SingleInformationWidget(
                    title: locale.email, value: userInfo!.email),
                _SingleInformationWidget(
                    title: locale.phone_number, value: userInfo!.phoneNumber),
                _SingleInformationWidget(
                    title: locale.governorate,
                    value: Helper.getGovernorateFromId(
                        int.parse(userInfo!.governorateId))
                        .getName(context)),
                const Divider(),
                SizedBox(
                  height: 16.h,
                ),
                Card(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        title: Text(locale.change_language),
                        onTap: () {
                          final dialog = ChooseLanguageDialog(
                              languageGroup: controller.languageGroup,
                              changeLanguage: controller.changeLanguage);
                          showDialog(
                              context: context, builder: (context) => dialog);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        title: Text(locale.logout),
                        onTap: () {
                          final dialog = AlertDialog(
                            content: Text(locale.confirm_logout),
                            actions: [
                              TextButton(
                                  onPressed: controller.logout,
                                  child: Text(locale.confirm)),
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text(locale.cancel))
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => dialog);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.contact_support,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        title: Text(locale.contact_with_us),
                        onTap: () => Get.toNamed(Routes.contactUs),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SingleInformationWidget extends StatelessWidget {
  const _SingleInformationWidget(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        // alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
            border: Border.all(color: Theme
                .of(context)
                .primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: style_400_14(
                  ColorManager.grey2,
                )),
            SizedBox(
              height: 6.h,
            ),
            Text(value,
                style: style_500_16(
                  ColorManager.blackTextColor,
                )),
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}
