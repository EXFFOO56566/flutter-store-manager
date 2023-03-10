import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/payment_form.dart';

class StoreSetupStep2 extends StatefulWidget {
  final VoidCallback goSkip;
  final VoidCallback goStart;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingBottom;

  const StoreSetupStep2({
    Key? key,
    required this.goSkip,
    required this.goStart,
    this.padding,
    this.paddingBottom,
  }) : super(key: key);

  @override
  State<StoreSetupStep2> createState() => _StoreSetupStep2State();
}

class _StoreSetupStep2State extends State<StoreSetupStep2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _method = 'paypal';
  Map<String, dynamic> _data = {};

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
    return Form(
      key: _formKey,
      child: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: 'Skip this step',
          textButtonPrimary: 'Get Start',
          onPressedSecondary: widget.goSkip,
          onPressedPrimary: () {
            if (_formKey.currentState!.validate()) {
              widget.goStart();
            }
          },
          padding: widget.paddingBottom,
        ),
        child: SingleChildScrollView(
          padding: widget.padding,
          child: PaymentForm(
            method: _method,
            data: _data,
            changeData: changeData,
            changeMethod: (String value) => setState(() {
              _method = value;
            }),
          ),
        ),
      ),
    );
  }
}
