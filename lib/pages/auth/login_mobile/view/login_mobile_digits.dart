import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/login_mobile/view/widgets/login_mobile_form.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

import '../bloc/login_mobile_bloc.dart';
import 'widgets/login_mobile_code_form.dart';

class DigitsException implements Exception {
  String? message;
  DigitsException(this.message);
}

///
/// Login Digits plugin
class LoginMobileDigits extends StatefulWidget {
  final String type;

  const LoginMobileDigits({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  LoginMobileDigitsState createState() => LoginMobileDigitsState();
}

class LoginMobileDigitsState extends State<LoginMobileDigits> with SnackMixin {
  late AuthenticationRepository _authenticationRepository;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
    super.didChangeDependencies();
  }

  _handleLoginAndRegister({required String countryCode, required String mobileNo, required String otp}) async {
    if (widget.type == "register") {
      context.read<LoginMobileBloc>().add(
            RegisterDigitsSubmitted(
              {
                'digits_reg_mobile': mobileNo,
                'digits_reg_countrycode': countryCode,
                'otp': otp,
              },
              callback,
            ),
          );
    } else {
      context.read<LoginMobileBloc>().add(
            LoginDigitsSubmitted(
              {
                'type': widget.type,
                'user': mobileNo,
                'countrycode': countryCode,
                'otp': otp,
              },
              callback,
            ),
          );
    }
  }

  Future<void> callback([bool navigate = true, dynamic e]) async {
    if (e != null) showError(context, e is RequestError ? e.message : e);
    if (navigate) Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  _onSubmit() async {
    LoginMobileState state = context.read<LoginMobileBloc>().state;

    // Exit if phone not validate
    if (state.status.isInvalid) {
      return;
    }

    PhoneNumber? phoneNumber = state.phone.value;
    String mobileNo = phoneNumber!.number!;
    String countryCode = phoneNumber.countryCode ?? '+';

    _setLoading(true);
    try {
      Map<String, dynamic> data = await _authenticationRepository.digitsSendOtp(
        requestData: RequestData(
          query: {
            'type': widget.type,
            'mobileNo': mobileNo,
            'countrycode': countryCode,
            'whatsapp': 0,
          },
          contentTypeHeader: 'application/x-www-form-urlencoded',
        ),
      );

      _setLoading(false);

      if (data['code']?.toString() == '1') {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            MediaQueryData mediaQuery = MediaQuery.of(context);
            double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

            return Container(
              constraints: BoxConstraints(maxHeight: height * 0.8, minHeight: height * 0.3),
              margin: mediaQuery.viewInsets,
              child: LoginMobileCodeForm(
                phone: mobileNo,
                onResent: () async {
                  try {
                    await _authenticationRepository.digitsReSendOtp(
                      requestData: RequestData(
                        query: {
                          'type': widget.type,
                          'mobileNo': mobileNo,
                          'countrycode': countryCode,
                          'whatsapp': 0,
                        },
                        contentTypeHeader: 'application/x-www-form-urlencoded',
                      ),
                    );
                  } catch (e) {
                    avoidPrint(e);
                  }
                },
                onVerify: (smsCode) async {
                  try {
                    final dataVerifyOtp = await _authenticationRepository.digitsVerifyOtp(
                      requestData: RequestData(
                        query: {
                          'type': widget.type,
                          'mobileNo': mobileNo,
                          'countrycode': countryCode,
                          'whatsapp': 0,
                          'otp': smsCode,
                        },
                        contentTypeHeader: 'application/x-www-form-urlencoded',
                      ),
                    );
                    if (dataVerifyOtp['code'] == 1) {
                      await _handleLoginAndRegister(mobileNo: mobileNo, countryCode: countryCode, otp: smsCode);
                    } else {
                      throw DigitsException(dataVerifyOtp['message']);
                    }
                  } catch (e) {
                    rethrow;
                  }
                },
              ),
            );
          },
        );
      } else {
        if (mounted) showError(context, data['message']);
      }
    } catch (e) {
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginMobileForm(loading: _loading, onSubmit: _onSubmit);
  }
}
