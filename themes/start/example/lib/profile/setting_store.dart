import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/setting_store_form.dart';

class SettingStoreScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting_store';

  const SettingStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'General Settings Stores'),
      body: FixedBottom(
        bottom: ElevatedButton(
          child: const Text('Save'),
          onPressed: () {},
        ),
        paddingBottom: const EdgeInsets.all(25),
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, 8, 25, 15),
          child: SettingStoreForm(),
        ),
      ),
    );
  }
}
