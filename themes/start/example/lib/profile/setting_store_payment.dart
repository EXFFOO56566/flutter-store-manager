import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/setting_store_payment_form.dart';

class SettingStorePaymentScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting_store_payment';

  const SettingStorePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Update Payment Method'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: SettingStorePaymentForm(),
      ),
    );
  }
}
