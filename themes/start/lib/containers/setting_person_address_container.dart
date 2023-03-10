import 'package:flutter/material.dart';

class SettingPersonAddressContainer extends StatelessWidget {
  final Widget billing;
  final Widget stock;
  final Widget shipping;

  const SettingPersonAddressContainer({
    Key? key,
    required this.billing,
    required this.stock,
    required this.shipping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        billing,
        stock,
        shipping,
      ],
    );
  }
}
