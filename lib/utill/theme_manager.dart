import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

import 'color_manager.dart';

ThemeData getLightTheme() {
  return ThemeData(
      // home colors
      primaryColor: ColorManager.primaryColor,
      focusColor: ColorManager.secondaryColor,
      scaffoldBackgroundColor: ColorManager.backgroundColor,
      splashColor: ColorManager.iconsColor,
      dialogBackgroundColor: ColorManager.whiteColor,
      textTheme: TextTheme(
          headlineSmall: style_400_14(ColorManager.blackTextColor),
          headlineMedium: style_400_16(ColorManager.blackTextColor),
          titleLarge: style_600_22(ColorManager.blackTextColor),
          titleMedium: style_500_16(ColorManager.blackTextColor),
          titleSmall: style_500_14(ColorManager.blackTextColor),
          bodyMedium: style_400_12(const Color(0xFF707070)),
        bodySmall: style_400_10(const Color(0xFF808C96),),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: style_500_16(ColorManager.primaryColor),
              padding: EdgeInsets.zero)),

      // bottomNavigationBar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.whiteColor,
        elevation: ValuesManager.elevation,
        selectedIconTheme: const IconThemeData(
          color: ColorManager.primaryColor,
        ),
        unselectedIconTheme: const IconThemeData(color: ColorManager.grey1),
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: ColorManager.grey1,
        selectedLabelStyle: style_400_8(ColorManager.primaryColor),
        unselectedLabelStyle: style_400_8(ColorManager.grey1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      iconTheme: const IconThemeData(color: ColorManager.iconsColor),
      // cardView theme
      cardTheme: const CardTheme(
          color: ColorManager.whiteColor,
          shadowColor: ColorManager.grey1,
          elevation: ValuesManager.elevation),
      // app bar theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.primaryColor,
            statusBarIconBrightness: Brightness.light),
        color: ColorManager.primaryColor,
        elevation: ValuesManager.elevation,
        titleTextStyle: style_500_17(ColorManager.whiteColor),
      ),
      // button theme
      buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primaryColor,
          splashColor: ColorManager.grey1),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: style_500_16(ColorManager.whiteColor),
              backgroundColor: ColorManager.primaryColor,
              disabledForegroundColor: ColorManager.disableColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ValuesManager.border)))),
      // Outlined button theme
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: OutlinedButton.styleFrom(
      //       padding: EdgeInsets.symmetric(vertical: AppHeight.h18),
      //       backgroundColor: ColorManager.darkPrimary,
      //       side: const BorderSide(
      //           color: ColorManager.greyScale_200, style: BorderStyle.solid),
      //       shape: RoundedRectangleBorder(
      //           side: const BorderSide(
      //             color: ColorManager.greyScale_200,
      //           ),
      //           borderRadius: BorderRadius.circular(AppRadius.r10))),
      // ),

      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        focusColor: ColorManager.blackTextColor,
        fillColor: ColorManager.whiteColor,
        hoverColor: ColorManager.grey1,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        hintStyle: style_400_16(ColorManager.grey1),
        labelStyle: style_600_16(ColorManager.blackTextColor),
        errorStyle: style_400_12(ColorManager.errorColor),
        //prefixIconColor: ColorManager.greyScale_500,
        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorManager.grey1, width: 1),
            borderRadius: BorderRadius.all(
                Radius.circular(ValuesManager.textFieldBorder))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorManager.primaryColor, width: 1),
            borderRadius: BorderRadius.all(
                Radius.circular(ValuesManager.textFieldBorder))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorManager.errorColor, width: 1.5),
            borderRadius: BorderRadius.all(
                Radius.circular(ValuesManager.textFieldBorder))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorManager.errorColor, width: 1.5),
            borderRadius: BorderRadius.all(
                Radius.circular(ValuesManager.textFieldBorder))),
      ));
}

// ThemeData getDarkTheme() {
//   return ThemeData(
//     // home colors
//     primaryColor: ColorManager.yellow,
//     accentColor: ColorManager.white2,
//     splashColor: ColorManager.grey2,
//     scaffoldBackgroundColor: ColorManager.black2,
//     textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(textStyle: style_600_14(ColorManager.yellow),padding: EdgeInsets.zero,foregroundColor: ColorManager.yellow)
//     ),
//     dialogBackgroundColor: ColorManager.black2,
//     // bottomNavigationBar theme
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: ColorManager.grey6,
//       elevation: AppFixedSize.s0,
//       selectedIconTheme: const IconThemeData(
//         color: ColorManager.yellow,
//       ),
//       unselectedIconTheme:
//           const IconThemeData(color: ColorManager.grey7),
//       selectedItemColor: ColorManager.yellow,
//       unselectedItemColor: ColorManager.grey7,
//       selectedLabelStyle: style_700_10(ColorManager.yellow),
//       unselectedLabelStyle: style_500_10(ColorManager.grey7),
//       showSelectedLabels: true,
//       showUnselectedLabels: true,
//       type: BottomNavigationBarType.fixed,
//     ),
//
//     // cardView theme
//     cardTheme: CardTheme(
//         color: ColorManager.black2,
//         shadowColor: ColorManager.grey2,
//         elevation: AppFixedSize.s4),
//
//     // app bar theme
//     appBarTheme: AppBarTheme(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: ColorManager.black2,
//           statusBarIconBrightness: Brightness.light,
//         ),
//         color: ColorManager.black2,
//         elevation: AppFixedSize.s0,
//         titleTextStyle: style_700_18(ColorManager.white)),
//
//     // button theme
//     buttonTheme: const ButtonThemeData(
//         shape: StadiumBorder(),
//           disabledColor: ColorManager.grey2,
//         buttonColor: ColorManager.yellow,
//         splashColor: ColorManager.grey2),
// iconTheme: IconThemeData(color: ColorManager.white2),
//     // elevated button them
//     elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//             textStyle: style_700_16(ColorManager.white),
//             backgroundColor: ColorManager.yellow,
//             disabledForegroundColor: ColorManager.grey2 ,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppRadius.r100)))),
//
//     // Outlined button theme
//     // outlinedButtonTheme: OutlinedButtonThemeData(
//     //   style: OutlinedButton.styleFrom(
//     //       padding: EdgeInsets.symmetric(vertical: AppHeight.h18),
//     //       backgroundColor: ColorManager.dark_2,
//     //       side: const BorderSide(
//     //           color: ColorManager.dark_3, style: BorderStyle.solid),
//     //       shape: RoundedRectangleBorder(
//     //           side: const BorderSide(
//     //             color: ColorManager.dark_3,
//     //           ),
//     //           borderRadius: BorderRadius.circular(AppRadius.r10))),
//     // ),
//     // input decoration theme (text form field)
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//         focusColor: ColorManager.grey2,
//         fillColor: ColorManager.grey2,
//         hoverColor: ColorManager.grey2,
//         prefixStyle: const TextStyle(color: ColorManager.white2),
//         contentPadding: EdgeInsets.symmetric(
//             vertical: AppHeight.h18, horizontal: AppWidth.w20),
//         hintStyle: style_400_14(ColorManager.grey8),
//         labelStyle: style_600_14(ColorManager.white),
//         errorStyle: style_400_12(ColorManager.red),
//         prefixIconColor: ColorManager.white2,
//         suffixIconColor: ColorManager.white2,
//
//         // enabled border style
//         enabledBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.white2, width: AppFixedSize.s1),
//             borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
//
//         // focused border style
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: ColorManager.yellow, width: AppFixedSize.s1),
//             borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
//
//         // error border style
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: ColorManager.red, width: AppFixedSize.s1),
//             borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
//         // focused border style
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.yellow, width: AppFixedSize.s1),
//             borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)))),
//   );
// }
