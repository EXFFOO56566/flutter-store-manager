import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../widgets/address_form.dart';

class SettingPersonAddressScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting_person_address';

  const SettingPersonAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Address'),
      body: FixedBottom(
        bottom: ElevatedButton(
          child: const Text('Save'),
          onPressed: () {},
        ),
        paddingBottom: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 15),
          child: SettingPersonAddressContainer(
            billing: SettingPersonAddressView(
              title: 'Billing Address',
              padding: const EdgeInsets.only(bottom: 18),
              child: AddressForm(
                data: const {},
                changeData: (String key, String value) {},
                padding: const EdgeInsets.only(top: 12, bottom: 18),
              ),
            ),
            stock: SettingPersonAddressStock(
              switchWidget: CupertinoSwitch(
                value: true,
                onChanged: (_) {},
              ),
            ),
            shipping: SettingPersonAddressView(
              title: 'Shipping Address',
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: AddressForm(
                data: const {},
                changeData: (String key, String value) {},
                padding: const EdgeInsets.only(top: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
