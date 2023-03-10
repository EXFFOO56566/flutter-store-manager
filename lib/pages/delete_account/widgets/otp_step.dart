import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../cubit/delete_account_cubit.dart';

class OtpStep extends StatefulWidget {
  final VoidCallback nextStep;
  final VoidCallback backStep;

  const OtpStep({
    Key? key,
    required this.nextStep,
    required this.backStep,
  }) : super(key: key);

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> with AppbarMixin, SnackMixin, LoadingMixin {
  final TextEditingController _controller = TextEditingController();
  bool _enableNext = false;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _enableNext = _controller.text.length == 6;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status is ErrorState) {
          dynamic error = state.status.props[0];
          showError(
            context,
            error is RequestError ? error.message : 'Fail',
          );
        }
        if (state.status is LoadedState) {
          widget.nextStep();
        }
      },
      child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
        listenWhen: (previous, current) => previous.statusSendOtp != current.statusSendOtp,
        listener: (context, state) {
          if (state.statusSendOtp is ErrorState) {
            dynamic error = state.statusSendOtp.props[0];
            showError(
              context,
              error is RequestError ? error.message : 'Fail',
            );
          }
          if (state.statusSendOtp is LoadedState) {
            showSuccess(context, translate('delete_account:text_otp_send_success'));
          }
        },
        child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
          buildWhen: (previous, current) =>
              previous.status != current.status || previous.statusSendOtp != current.statusSendOtp,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: leading(onPressed: widget.backStep),
                shadowColor: Colors.transparent,
              ),
              body: FixedBottom(
                paddingBottom: const EdgeInsets.all(25),
                bottom: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: theme.textTheme.subtitle1?.color,
                          backgroundColor: theme.colorScheme.surface,
                        ),
                        child: Text(translate('delete_account:text_agree_cancel')),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _enableNext
                            ? () {
                                if (state.status is! LoadingState) {
                                  context.read<DeleteAccountCubit>().deleteAccount(otp: _controller.text);
                                }
                              }
                            : null,
                        child: state.status is LoadingState
                            ? buildLoadingElevated()
                            : Text(translate('delete_account:text_agree_send')),
                      ),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(25, 8, 25, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate('delete_account:text_otp_title'),
                        style: theme.textTheme.headline5,
                      ),
                      Text.rich(
                        TextSpan(
                          text: translate('delete_account:text_otp_subtitle'),
                          children: [
                            TextSpan(
                              text: ' ${context.read<AuthenticationBloc>().state.user.userEmail}',
                              style: TextStyle(color: theme.textTheme.headline6?.color),
                            )
                          ],
                        ),
                        style: theme.textTheme.bodyText2?.copyWith(color: theme.textTheme.caption?.color),
                      ),
                      const SizedBox(height: 32),
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
                          borderWidth: 1,
                        ),
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        backgroundColor: Colors.transparent,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        onChanged: (_) {},
                        beforeTextPaste: (text) {
                          avoidPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
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
                            return null;
                          } else {
                            return null;
                          }
                        },
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        textStyle: const TextStyle(fontSize: 20, height: 1.6),
                        enableActiveFill: false,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translate('auth:text_get_otp'),
                            style: theme.textTheme.bodyText1,
                          ),
                          TextButton(
                            onPressed: () {
                              if (state.statusSendOtp is! LoadingState) {
                                context.read<DeleteAccountCubit>().sendOtp();
                              }
                            },
                            child: Text(translate('auth:text_resend')),
                          ),
                        ],
                      ),
                      if (state.statusSendOtp is LoadingState) Center(child: buildLoading()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
