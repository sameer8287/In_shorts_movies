import 'package:flutter/material.dart';
import '../l10n/generated/l10n.dart';

class AppTheme {
  static const String _fontFamily = 'Roboto';

  static const blueColor = Color(0xFF005191);
  static const whiteBackground = Color(0xFFFFFFFF);
  static const textColor = Color(0xFF232121);
  static const hintColor = Color(0x89232121);
  static const textFormFieldOutlineClr = Color(0xffD9D9D9);
  static const stepperTextColor = Color(0xff6E7073);
  static const unselectedGrey = Color(0xffB5B5B5);
  static const whiteClr = Color(0xffffffff);

  static const primaryBlue = Color(0xff005191);
  static const primaryRed = Color(0xffDD1367);
  static const secondaryGrey = Color(0xffa6a6ad);

  static const blackColor = Color(0xffDDFFDE);

  static const bottomNavColor = Color(0xffF5F6F7);
  static const primaryColor = Color(0xff503CEB);


  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: whiteBackground,
      primaryColor: blueColor,
      colorScheme: ColorScheme.light(
        primary: blueColor,
        secondary: primaryRed,
        surface: whiteClr,
        onPrimary: whiteClr,
        onSecondary: whiteClr,
        onSurface: textColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryBlue,
        selectionColor: primaryBlue.withAlpha(50),
        selectionHandleColor: primaryBlue,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14.0, color: textColor),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 16.0, color: textColor),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 12.0, color: textColor),
        headlineMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 20.0, color: textColor),
        headlineLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 24.0, color: textColor),
        headlineSmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 18.0, color: textColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: textFormFieldOutlineClr, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: textFormFieldOutlineClr, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: primaryBlue, width: 1),
        ),
        hintStyle: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14.0, color: hintColor),
      ),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.all(secondaryGrey), checkColor: WidgetStateProperty.all(primaryBlue)),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: whiteClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        constraints: BoxConstraints(minHeight: 500),
        showDragHandle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          textStyle: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700, color: whiteClr, fontSize: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
      bottomAppBarTheme: BottomAppBarThemeData(color: whiteClr, elevation: 0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(enableFeedback: false, type: BottomNavigationBarType.fixed),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.all(primaryBlue), trackColor: WidgetStateProperty.all(unselectedGrey)),
      dialogTheme: DialogThemeData(
        backgroundColor: whiteClr,
        insetPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      appBarTheme: AppBarTheme(color: whiteClr, elevation: 0, surfaceTintColor: Colors.transparent),
      expansionTileTheme: ExpansionTileThemeData(iconColor: primaryBlue, textColor: textColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: blackColor,
      primaryColor: primaryBlue,
      colorScheme: ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryRed,
        surface: blackColor,
        onPrimary: whiteClr,
        onSecondary: whiteClr,
        onSurface: stepperTextColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14.0, color: whiteClr),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 16.0, color: whiteClr),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 12.0, color: whiteClr),
        headlineMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 20.0, color: whiteClr),
        headlineLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 24.0, color: whiteClr),
        headlineSmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 18.0, color: whiteClr),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: textFormFieldOutlineClr)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: textFormFieldOutlineClr)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryBlue, width: 2.0)),
        hintStyle: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14.0, color: hintColor),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: blackColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        constraints: BoxConstraints(minHeight: 500),
        showDragHandle: true,
      ),
      dialogTheme: DialogThemeData(backgroundColor: blackColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          textStyle: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }
}

extension Themes on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  S get translate => S.of(this);
}
