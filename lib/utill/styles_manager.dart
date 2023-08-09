import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// thin style

// TextStyle getThinStyle({required double fontSize, required Color color}) {
//   return _getTextStyle(fontSize, FontWeightManager.thin, color);
// }

// extraLight style

// TextStyle getExtraLightStyle({required double fontSize, required Color color}) {
//   return _getTextStyle(fontSize, FontWeightManager.extraLight, color);
// }

// light style

// TextStyle getLightStyle({required double fontSize, required Color color}) {
//   return _getTextStyle(fontSize, FontWeightManager.light, color);
// }

// regular style

TextStyle getRegularStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
// semiBold style

TextStyle getSemiBoldStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

// bold style

TextStyle getBoldStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// extraBold style

// TextStyle getExtraBoldStyle({required double fontSize, required Color color}) {
//   return _getTextStyle(fontSize, FontWeightManager.extraBold, color);
// }

// black style

// TextStyle getBlackStyle({required double fontSize, required Color color}) {
//   return _getTextStyle(fontSize, FontWeightManager.black, color);
// }

// TextStyle style_900_96(Color color) {
//   return getBlackStyle(fontSize: FontSize.s96, color: color);
// }

TextStyle style_700_48(Color color) {
  return getBoldStyle(fontSize: FontSize.s48, color: color);
}

TextStyle style_700_40(Color color) {
  return getBoldStyle(fontSize: FontSize.s40, color: color);
}

TextStyle style_700_32(Color color) {
  return getBoldStyle(fontSize: FontSize.s32, color: color);
}

TextStyle style_700_24(Color color) {
  return getBoldStyle(fontSize: FontSize.s24, color: color);
}

TextStyle style_700_20(Color color) {
  return getBoldStyle(fontSize: FontSize.s20, color: color);
}

TextStyle style_700_18(Color color) {
  return getBoldStyle(fontSize: FontSize.s18, color: color);
}

TextStyle style_700_16(Color color) {
  return getBoldStyle(fontSize: FontSize.s16, color: color);
}

TextStyle style_700_14(Color color) {
  return getBoldStyle(fontSize: FontSize.s14, color: color);
}

TextStyle style_700_10(Color color) {
  return getBoldStyle(fontSize: FontSize.s10, color: color);
}
TextStyle style_600_22(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s22, color: color);
}

TextStyle style_600_18(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s18, color: color);
}

TextStyle style_600_16(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s16, color: color);
}
TextStyle style_600_15(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s15, color: color);
}
TextStyle style_600_14(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s14, color: color);
}

TextStyle style_600_10(Color color) {
  return getSemiBoldStyle(fontSize: FontSize.s10, color: color);
}
TextStyle style_500_22(Color color) {
  return getMediumStyle(fontSize: FontSize.s22, color: color);
}
TextStyle style_500_18(Color color) {
  return getMediumStyle(fontSize: FontSize.s18, color: color);
}

TextStyle style_500_17(Color color) {
  return getMediumStyle(fontSize: FontSize.s17, color: color);
}

TextStyle style_500_16(Color color) {
  return getMediumStyle(fontSize: FontSize.s16, color: color);
}

TextStyle style_500_14(Color color) {
  return getMediumStyle(fontSize: FontSize.s14, color: color);
}
TextStyle style_500_13(Color color) {
  return getMediumStyle(fontSize: FontSize.s13, color: color);
}

TextStyle style_500_12(Color color) {
  return getMediumStyle(fontSize: FontSize.s12, color: color);
}

TextStyle style_500_10(Color color) {
  return getMediumStyle(fontSize: FontSize.s10, color: color);
}

TextStyle style_400_25(Color color) {
  return getRegularStyle(fontSize: FontSize.s25, color: color);
}
TextStyle style_400_18(Color color) {
  return getRegularStyle(fontSize: FontSize.s18, color: color);
}

TextStyle style_400_16(Color color) {
  return getRegularStyle(fontSize: FontSize.s16, color: color);
}

TextStyle style_400_14(Color color) {
  return getRegularStyle(fontSize: FontSize.s14, color: color);
}
TextStyle style_400_13(Color color) {
  return getRegularStyle(fontSize: FontSize.s13, color: color);
}
TextStyle style_400_12(Color color) {
  return getRegularStyle(fontSize: FontSize.s12, color: color);
}
TextStyle style_400_10(Color color) {
  return getRegularStyle(fontSize: FontSize.s10, color: color);
}
TextStyle style_400_8(Color color) {
  return getRegularStyle(fontSize: FontSize.s8, color: color);
}
