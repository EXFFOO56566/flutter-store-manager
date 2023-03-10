import 'package:flutter/material.dart';

class SettingContainer extends StatelessWidget {
  final Widget profile;
  final Widget store;

  const SettingContainer({
    Key? key,
    required this.profile,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profile,
        const SizedBox(height: 30),
        store,
      ],
    );
  }
}
