import 'package:flutter/material.dart';

import '../../widgets/address_form.dart';

class SettingStoreAddressForm extends StatefulWidget {
  const SettingStoreAddressForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingStoreAddressForm> createState() => _SettingStoreAddressFormState();
}

class _SettingStoreAddressFormState extends State<SettingStoreAddressForm> {
  Map<String, dynamic> _data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void changeData(String key, String value) {
    setState(() {
      _data = {
        ..._data,
        key: value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressForm(
          data: _data,
          changeData: changeData,
          isName: false,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('Save'),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
