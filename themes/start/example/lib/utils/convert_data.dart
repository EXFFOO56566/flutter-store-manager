import 'package:flutter/material.dart';

/// This is utility convert data for app
///
class ConvertData {
  /// This helper function convert any value to `double`
  ///
  static double stringToDouble(dynamic value, [double defaultValue = 0]) {
    if (value == null || value == "") {
      return defaultValue;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }

    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }

    return defaultValue;
  }

  /// This helper function convert any value to `double` and `null`
  ///
  /// In some case we need this, like when both value `double` and `null` accepted
  /// If you want always return `double` value try function [stringToDouble] instead
  ///
  static double? stringToDoubleCanBeNull(dynamic value, [double? defaultValue]) {
    if (value == null || value == "") {
      return defaultValue;
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is double) {
      return value;
    }

    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }

    return defaultValue;
  }

  /// Convert String to int
  static int stringToInt([dynamic value = '0', int initValue = 0]) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? initValue;
    }
    return initValue;
  }

  static Color fromRgba(String rgbaString) {
    if (rgbaString == "" || rgbaString.substring(0, 5) != 'rgba(') {
      return Colors.black;
    }

    List textNumber = rgbaString.substring(5, rgbaString.length - 1).split(',');
    int r = stringToInt(textNumber[0], 255);
    int g = stringToInt(textNumber[1], 255);
    int b = stringToInt(textNumber[2], 255);
    double o = stringToDouble(textNumber[3], 1);

    return Color.fromRGBO(r, g, b, o);
  }

  /// Create a color from red, green, blue, and opacity
  static Color fromRGBA(Map? color, [defaultColor]) {
    if (color is! Map<String, dynamic> || color['r'] == null || color['g'] == null || color['b'] == null) {
      return defaultColor ?? Colors.white;
    }

    int r = color['r'].toInt();
    int? g = color['g'].toInt();
    int? b = color['b'].toInt();
    double? a = color['a'] == null ? 1 : color['a'].toDouble();

    if (r < 0 || r > 255) return defaultColor ?? Colors.white;
    if (g! < 0 || g > 255) return defaultColor ?? Colors.white;
    if (b! < 0 || b > 255) return defaultColor ?? Colors.white;
    return Color.fromRGBO(r, g, b, a!);
  }

  ///
  /// Convert color from hex
  static Color? fromHex(String hex, [defaultColor = Colors.white]) {
    if (!RegExp(r'^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{5}|[a-fA-F0-9]{3})$').hasMatch(hex)) {
      return defaultColor;
    }
    String color = hex.replaceAll('#', '');
    String value = color.length == 6 ? color : '';
    if (value.length != 6) {
      if (color.length == 3) {
        for (int i = 0; i < color.length; i++) {
          value = '$value${color[i]}${color[i]}';
        }
      } else if (color.length == 5) {
        value = '${color.substring(0, 4)}0${color[4]}';
      }
    }
    return Color(int.parse('0xff$value'));
  }

  static String fromColor(Color color) {
    String hex = color.value.toRadixString(16);

    return '#${hex.substring(2)}';
  }
}
