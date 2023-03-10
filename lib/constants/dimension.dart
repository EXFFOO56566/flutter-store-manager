import 'package:flutter/material.dart';

const double designScreenHeight = 812;
const double designScreenWidth = 375;

class Dimension {
  double? width;
  double? height;

  Dimension(this.width, this.height);
}

Dimension dimension(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;

  return Dimension(w, h);
}

double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double height(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.height / designScreenHeight;

  return (size * ratio).ceil().toDouble();
}

double width(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.width / designScreenWidth;
  return (size * ratio).ceil().toDouble();
}

double fontSize(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.width / designScreenWidth;
  return (size * ratio).ceil().toDouble();
}
