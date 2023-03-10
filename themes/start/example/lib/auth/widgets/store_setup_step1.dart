import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/address_form.dart';

class StoreSetupStep1 extends StatefulWidget {
  final VoidCallback goSkip;
  final Function(Map<String, dynamic>, bool) goStart;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingBottom;

  const StoreSetupStep1({
    Key? key,
    required this.goSkip,
    required this.goStart,
    this.padding,
    this.paddingBottom,
  }) : super(key: key);

  @override
  State<StoreSetupStep1> createState() => _StoreSetupStep1State();
}

class _StoreSetupStep1State extends State<StoreSetupStep1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _address = {};

  bool _showEmail = true;

  void changeAddress(String key, String value) {
    setState(() {
      _address = {
        ..._address,
        key: value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String initPerPage = _address['perPage'] ?? '';

    return Form(
      key: _formKey,
      child: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: 'Skip this step',
          textButtonPrimary: 'Get Start',
          onPressedSecondary: widget.goSkip,
          onPressedPrimary: () {
            if (_formKey.currentState!.validate()) {
              widget.goStart(_address, _showEmail);
            }
          },
          padding: widget.paddingBottom,
        ),
        child: SingleChildScrollView(
          padding: widget.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(
                label: 'Store Product Per Page',
                initialValue: initPerPage,
                onChanged: (String value) => changeAddress('perPage', value),
              ),
              const SizedBox(height: 15),
              AddressForm(
                data: _address,
                changeData: changeAddress,
                isName: false,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Text('Show email address in store', style: theme.textTheme.caption)),
                  CupertinoSwitch(
                    value: _showEmail,
                    onChanged: (_) => setState(() {
                      _showEmail = !_showEmail;
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
