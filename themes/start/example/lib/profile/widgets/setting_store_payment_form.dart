import 'package:flutter/material.dart';

import '../../widgets/payment_form.dart';

class SettingStorePaymentForm extends StatefulWidget {
  const SettingStorePaymentForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingStorePaymentForm> createState() => _SettingStorePaymentFormState();
}

class _SettingStorePaymentFormState extends State<SettingStorePaymentForm> {
  String _method = 'paypal';
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
        PaymentForm(
          method: _method,
          data: _data,
          changeData: changeData,
          changeMethod: (String value) => setState(() {
            _method = value;
          }),
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
