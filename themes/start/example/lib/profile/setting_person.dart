import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/setting_person_form.dart';

class SettingPersonScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting_person';

  const SettingPersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Personal'),
      body: const SettingPersonForm(),
    );
  }
}
