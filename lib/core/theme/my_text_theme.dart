import 'package:flutter/material.dart';

import '../constants/asset_constant.dart';
import 'app_theme.dart';

class MyTextTheme {
  static TextStyle myTitleLargeTheme({Color? textColor, double? fontSize}) {
    return TextStyle(fontWeight: FontWeight.w600, fontFamily: AssetConstant.roboto, color: textColor ?? AppTheme.textColor, fontSize: fontSize ?? 28);
  }

  static TextStyle myBodySmallTheme({Color? textColor, FontWeight? fontWeight, double? fontSize, TextOverflow? overflow}) {
    return TextStyle(
      color: textColor ?? AppTheme.textColor,
      fontFamily: AssetConstant.roboto,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      overflow: overflow,
    );
  }

  static TextStyle myBodyMediumTheme({Color? textColor, FontWeight? fontWeight, double? fontSize, TextOverflow? overflow}) {
    return TextStyle(
      color: textColor ?? AppTheme.textColor,
      fontSize: fontSize ?? 17,
      fontFamily: AssetConstant.roboto,
      overflow: overflow,
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }

  static TextStyle myBodyLargeTheme({Color? textColor, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      color: textColor ?? AppTheme.textColor,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 20,
      fontFamily: AssetConstant.roboto,
    );
  }
}
