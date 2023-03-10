// Flutter library
import 'dart:async';
import 'package:flutter/material.dart';

// Dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// Configs & Utils
import 'package:flutter_store_manager/constants/color_block.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

import '../login_mobile_digits.dart';

class LoginMobileCodeForm extends StatefulWidget {
  final String phone;
  final Future<void> Function(String smsCode) onVerify;
  final Future<void> Function() onResent;

  const LoginMobileCodeForm({
    Key? key,
    required this.phone,
    required this.onVerify,
    required this.onResent,
  }) : super(key: key);

  @override
  LoginMobileCodeFormState createState() => LoginMobileCodeFormState();
}

class LoginMobileCodeFormState extends State<LoginMobileCodeForm> {
  final _formKey = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> _errorController;

  String _currentText = "";
  String? _errorMessage;

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

  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  String getPhone() {
    if (widget.phone.length < 3) {
      return widget.phone;
    }
    return '${widget.phone.substring(0, widget.phone.length - 3)}***';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          errorBorder: InputBorder.none,
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 24, 25, 32),
          child: LoginMobileCode(
            title: translate('auth:text_verify'),
            subtitle: RichText(
              text: TextSpan(
                text: translate('auth:text_sub_verify'),
                children: [
                  TextSpan(
                    text: ' ${getPhone()}',
                    style: theme.textTheme.bodyText2,
                  )
                ],
                style: theme.textTheme.caption,
              ),
            ),
            form: Column(
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
                    borderWidth: 1,
                    errorBorderColor: theme.colorScheme.error,
                  ),
                  errorAnimationController: _errorController,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {},
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
                if (_errorMessage != null) ...[
                  const SizedBox(height: 24),
                  Text(_errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
                ],
                const SizedBox(height: 84),
                _Resend(onResent: widget.onResent, initValue: 60),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: _ButtonVerify(
                    keyForm: _formKey,
                    errorController: _errorController,
                    smsCode: _currentText,
                    onVerify: widget.onVerify,
                    setError: _setError,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonVerify extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final StreamController<ErrorAnimationType> errorController;
  final void Function(String message) setError;
  final Future<void> Function(String smsCode) onVerify;
  final String smsCode;

  const _ButtonVerify({
    Key? key,
    required this.keyForm,
    required this.errorController,
    required this.onVerify,
    required this.smsCode,
    required this.setError,
  }) : super(key: key);

  @override
  State<_ButtonVerify> createState() => _ButtonVerifyState();
}

class _ButtonVerifyState extends State<_ButtonVerify> with LoadingMixin {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!_loading) {
          if (widget.keyForm.currentState!.validate()) {
            try {
              setState(() {
                _loading = true;
              });
              await widget.onVerify(widget.smsCode);
              setState(() {
                _loading = false;
              });
              if (mounted) {
                Navigator.of(context).pop(widget.smsCode);
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-verification-code') {
                widget.setError(AppLocalizations.of(context)!.translate('validate:text_invalid_verification_code'));
              } else {
                if (e.message != null) widget.setError(e.message!);
              }
              setState(() {
                _loading = false;
              });
            } on DigitsException catch (e) {
              if (e.message != null) widget.setError(e.message!);
              setState(() {
                _loading = false;
              });
            }
          } else {
            widget.errorController.add(ErrorAnimationType.shake);
          }
        }
      },
      child: _loading ? buildLoadingElevated() : Text(AppLocalizations.of(context)!.translate('auth:text_verify_now')),
    );
  }
}

class _Resend extends StatefulWidget {
  const _Resend({Key? key, required this.onResent, this.initValue}) : super(key: key);

  final Future<void> Function() onResent;
  final int? initValue;

  @override
  State<_Resend> createState() => _ResendState();
}

class _ResendState extends State<_Resend> {
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    if (widget.initValue != null) {
      setState(() {
        _start = widget.initValue!;
      });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _startTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    List<Widget> result = [
      Text(translate('auth:text_resend_code_in', {'time': '$_start'}), style: theme.textTheme.caption),
    ];

    if (_start == 0) {
      result = [
        Text(translate('auth:text_get_otp'), style: theme.textTheme.caption),
        TextButton(
          onPressed: () async {
            await widget.onResent();
            setState(() {
              _start = 60;
            });
            _startTimer();
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            textStyle: theme.textTheme.button?.copyWith(fontSize: theme.textTheme.caption?.fontSize),
          ),
          child: Text(translate('auth:text_resend')),
        )
      ];
    }

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: result,
    );
  }
}
