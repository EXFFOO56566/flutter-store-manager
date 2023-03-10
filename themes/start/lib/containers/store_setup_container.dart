import 'package:flutter/material.dart';

class StoreSetupContainer extends StatelessWidget {
  final Widget tabbar;
  final Widget content;

  const StoreSetupContainer({
    Key? key,
    required this.tabbar,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [tabbar, Expanded(child: content)]);
  }
}
