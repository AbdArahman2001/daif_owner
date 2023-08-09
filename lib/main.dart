import 'dart:developer';
import 'dart:io';
import 'package:daif_owner/helper/package_info_helper.dart';
import 'package:daif_owner/routes/app_pages.dart';
import 'package:daif_owner/view/screens/dashboard/screen/dashboard_screen.dart';
import 'package:daif_owner/view/screens/my_places/screen/add_or_update_chalet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:daif_owner/utill/theme_manager.dart';
import 'controller/calendar_controller.dart';
import 'controller/my_places_controller.dart';
import 'controller/profile_controller.dart';
import 'data/local/my_shared_pref.dart';
import 'data/model/response/user_model.dart';
import 'di_container.dart' as di;
import 'helper/custom_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/l10n.dart';

late UserModel? userInfo ;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => MyPlacesController());
  Get.lazyPut(() => CalendarController());
  Get.lazyPut(() => ProfileController());
  await MySharedPref.instance.init();
  userInfo = MySharedPref.instance.getUserInfo();
  log(userInfo?.image.toString()??"");
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GetMaterialApp(
              themeMode: ThemeMode.light,
              theme: getLightTheme(),
              debugShowCheckedModeBanner: false,
          locale: MySharedPref.instance.getCurrentLocal(),
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
            getPages: AppPages.routes,
            ));
  }
}
