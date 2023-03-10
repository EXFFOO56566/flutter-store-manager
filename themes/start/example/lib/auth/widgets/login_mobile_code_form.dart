import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:example/constants/color_block.dart';

class LoginMobileCodeForm extends StatefulWidget {
  final ValueChanged<String> clickVerifyCode;

  const LoginMobileCodeForm({
    Key? key,
    required this.clickVerifyCode,
  }) : super(key: key);

  @override
  State<LoginMobileCodeForm> createState() => _LoginMobileCodeFormState();
}

class _LoginMobileCodeFormState extends State<LoginMobileCodeForm> {
  String _currentText = "";
  final _formKey = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> _errorController;

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          errorBorder: InputBorder.none,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            PinCodeTextField(
              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 48,
                fieldWidth: 48,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
                inactiveColor: theme.dividerColor,
                activeColor: ColorBlock.green,
                selectedColor: theme.primaryColor,
                errorBorderColor: theme.colorScheme.error,
                borderWidth: 1,
              ),
              keyboardType: TextInputType.number,
              onCompleted: (v) {},
              errorAnimationController: _errorController,
              backgroundColor: Colors.transparent,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              onChanged: (value) {
                setState(() {
                  _currentText = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade300,
                fontWeight: FontWeight.bold,
              ),
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return '';
                } else {
                  return null;
                }
              },
              animationDuration: const Duration(milliseconds: 300),
              textStyle: theme.textTheme.headline6,
            ),
            const SizedBox(height: 84),
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('get back OTP?', style: theme.textTheme.caption),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    textStyle: theme.textTheme.button?.copyWith(fontSize: theme.textTheme.caption?.fontSize),
                  ),
                  child: const Text('RESEND'),
                )
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.clickVerifyCode(_currentText);
                  } else {
                    _errorController.add(ErrorAnimationType.shake);
                  }
                },
                child: const Text('Verify Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
