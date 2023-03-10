import 'package:flutter/material.dart';

class CustomCircleLoading extends StatelessWidget {
  final double strokeWidth;
  final double size;
  final Color color;

  const CustomCircleLoading({Key? key, this.strokeWidth = 2, this.size = 24, this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
