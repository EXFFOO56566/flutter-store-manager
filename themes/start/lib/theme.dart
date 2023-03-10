import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/constants/color_theme.dart';

String fontFamily = 'ProductSans';

ButtonStyle _buildButtonStyleData(
  String type, {
  required Color color,
  required Color pressedColor,
  required Color disableColor,
  required Color disableTextColor,
}) {
  Size minimumSize = const Size(0, 51);
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 40);
  BorderRadius borderRadius = BorderRadius.circular(8);
  switch (type) {
    case 'text':
      return ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(pressedColor.withOpacity(0.05)),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disableTextColor;
          }
          if (states.contains(MaterialState.pressed)) {
            return pressedColor;
          }

          return color;
        }),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    case 'outlined':
      return ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disableTextColor;
          } else if (states.contains(MaterialState.pressed)) {
            return pressedColor;
          }

          return color;
        }),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        minimumSize: MaterialStateProperty.all<Size>(minimumSize),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: borderRadius)),
        side: MaterialStateProperty.resolveWith((states) {
          Color borderColor;

          if (states.contains(MaterialState.disabled)) {
            borderColor = disableColor;
          } else if (states.contains(MaterialState.pressed)) {
            borderColor = pressedColor;
          } else {
            borderColor = color;
          }

          return BorderSide(color: borderColor, width: 1);
        }),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    default:
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disableColor;
          } else if (states.contains(MaterialState.pressed)) {
            return pressedColor;
          }
          return color;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disableTextColor;
          }

          return Colors.white;
        }),
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        minimumSize: MaterialStateProperty.all<Size>(minimumSize),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: borderRadius)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
  }
}

InputDecorationTheme _buildInputDecorationTheme({
  required InputDecorationTheme base,
  required TextTheme textTheme,
  required Color borderColor,
  required Color focusBorderColor,
  required Color errorColor,
}) {
  double borderRadius = 10;

  return base.copyWith(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    enabledBorder: _buildInputBorder(borderRadius, borderColor, 1),
    border: _buildInputBorder(borderRadius, borderColor, 1),
    focusedBorder: _buildInputBorder(borderRadius, focusBorderColor, 1),
    errorBorder: _buildInputBorder(borderRadius, errorColor, 1),
    disabledBorder: _buildInputBorder(borderRadius, borderColor, 1),
    labelStyle: textTheme.caption,
    hintStyle: textTheme.caption,
    helperStyle: textTheme.caption,
    errorStyle: textTheme.overline!.copyWith(color: errorColor),
    errorMaxLines: 5,
  );
}

InputBorder _buildInputBorder(
  double textFieldsBorderRadius,
  Color textFieldsBorderColor,
  double textFieldsBorderWidth,
) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFieldsBorderRadius),
    borderSide: BorderSide(color: textFieldsBorderColor, width: textFieldsBorderWidth),
  );
}

TextTheme _buildTextTheme(TextTheme base, String fontFamily, Color color, Color secondColor, Color thirdColor) {
  return base.copyWith(
    headline1:
        base.headline1!.copyWith(fontFamily: fontFamily, fontSize: 96, fontWeight: FontWeight.w500, color: color),
    headline2:
        base.headline2!.copyWith(fontFamily: fontFamily, fontSize: 60, fontWeight: FontWeight.w500, color: color),
    headline3:
        base.headline3!.copyWith(fontFamily: fontFamily, fontSize: 48, fontWeight: FontWeight.w500, color: color),
    headline4:
        base.headline4!.copyWith(fontFamily: fontFamily, fontSize: 34, fontWeight: FontWeight.w500, color: color),
    headline5: base.headline5!.copyWith(
      fontFamily: fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: color,
      height: 34 / 28,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    headline6: base.headline6!.copyWith(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: color,
      height: 30 / 24,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    subtitle1: base.subtitle1!.copyWith(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
      height: 22 / 18,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    subtitle2: base.subtitle2!.copyWith(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      height: 19 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    bodyText1: base.bodyText1!.copyWith(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
      height: 19 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    bodyText2: base.bodyText2!.copyWith(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
      height: 24 / 14,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    button: base.button!.copyWith(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      height: 19 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    caption: base.caption!.copyWith(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondColor,
      height: 24 / 14,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    overline: base.overline!.copyWith(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: thirdColor,
      letterSpacing: 0,
      height: 17 / 12,
      leadingDistribution: TextLeadingDistribution.even,
    ),
  );
}

ThemeData getCustomThemeData({Brightness? brightness}) {
  final ThemeData base = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
  final ColorTheme colorTheme = brightness == Brightness.dark ? colorThemeDark : colorThemeLight;
  final TextTheme textTheme = _buildTextTheme(
    base.textTheme,
    fontFamily,
    colorTheme.textColor,
    colorTheme.textSecondaryColor,
    colorTheme.textThirdColor,
  );

  final ColorScheme colorScheme = base.colorScheme.copyWith(
    surface: colorTheme.surfaceColor,
    error: colorTheme.errorColor,
  );

  return base.copyWith(
    primaryColor: colorTheme.primaryColor,
    primaryColorDark: colorTheme.primaryColorDark,
    primaryColorLight: colorTheme.primaryColorLight,
    scaffoldBackgroundColor: colorTheme.scaffoldBackgroundColor,
    dividerColor: colorTheme.dividerColor,
    cardColor: colorTheme.cardColor,
    canvasColor: colorTheme.canvasColor,
    textTheme: textTheme,
    colorScheme: colorScheme,
    textSelectionTheme: TextSelectionThemeData(cursorColor: colorTheme.cursorColor),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorTheme.snackBarBackgroundColor,
      contentTextStyle: textTheme.bodyText2?.copyWith(color: colorTheme.snackBarColor),
      actionTextColor: colorTheme.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      behavior: SnackBarBehavior.floating,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: textTheme.subtitle1?.color,
      ),
      titleTextStyle: textTheme.subtitle2,
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: brightness == Brightness.dark
          ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    ),
    inputDecorationTheme: _buildInputDecorationTheme(
      base: base.inputDecorationTheme,
      textTheme: textTheme,
      borderColor: colorTheme.dividerColor,
      focusBorderColor: colorTheme.inputFocusBorderColor,
      errorColor: colorTheme.errorColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorTheme.bottomSheetBackgroundColor,
      modalBackgroundColor: colorTheme.bottomSheetModalBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: _buildButtonStyleData(
      'text',
      color: colorTheme.primaryColor,
      pressedColor: colorTheme.primaryColorDark,
      disableColor: colorTheme.textButtonDisableColor,
      disableTextColor: colorTheme.textButtonDisableTextColor,
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _buildButtonStyleData(
        'elevated',
        color: colorTheme.primaryColor,
        pressedColor: colorTheme.primaryColorDark,
        disableColor: colorTheme.elevatedButtonDisableColor,
        disableTextColor: colorTheme.elevatedButtonDisableTextColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _buildButtonStyleData(
        'outlined',
        color: colorTheme.primaryColor,
        pressedColor: colorTheme.primaryColorDark,
        disableColor: colorTheme.outlinedButtonDisableColor,
        disableTextColor: colorTheme.outlinedButtonDisableTextColor,
      ),
    ),
  );
}
