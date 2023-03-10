import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/setting_store_address_form.dart';

class SettingStoreAddressScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting_store_address';

  const SettingStoreAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Store Address'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(25, 8, 25, 25),
        child: SettingStoreAddressForm(),
      ),
    );
  }
}
