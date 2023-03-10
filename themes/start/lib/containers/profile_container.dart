import 'package:flutter/material.dart';
import 'package:ui/mixins/mixins.dart';

class ProfileContainer extends StatelessWidget with AppbarMixin {
  final Widget user;
  final Widget information;
  final Widget setting;
  final Widget footer;
  final EdgeInsetsGeometry? padding;

  const ProfileContainer({
    Key? key,
    required this.user,
    required this.information,
    required this.setting,
    required this.footer,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user,
          const SizedBox(height: 20),
          information,
          const SizedBox(height: 30),
          setting,
          const SizedBox(height: 20),
          footer
        ],
      ),
    );
  }
}
