import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'styles.dart';

const bool isWeb = kIsWeb;

const double tabVerticalWidth = 108;

const double endReachedThreshold = 200;

const double initLat = 37.33233141;

const double initLng = -122.0312186;

const double initZoom = 14.4746;

const double enableBearing = 192.8334901395799;

const double enableTilt = 59.440717697143555;

const double enableZoom = 19.151926040649414;

const EdgeInsetsDirectional defaultScreenPadding = EdgeInsetsDirectional.zero;

const double appbarEmptySpace = 125.0;

const int spaceTimeNew = 30;

const bool enableCaptchaLogin = true;

const bool enableCaptchaRegister = true;

const List<BoxShadow> initShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    offset: Offset(0, -5),
    blurRadius: 10,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> secondaryShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.08),
    offset: Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> thirdShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    offset: Offset(0, 5),
    blurRadius: 15,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> forthShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 95, 255, 0.15),
    offset: Offset(0, 9),
    blurRadius: 9,
    spreadRadius: 0,
  ),
];
