import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/forgot_password/forgot_password.dart';
import 'package:flutter_store_manager/pages/auth/login/login.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../../../constants/constants.dart';
import '../../../captcha/captcha.dart';

class LoginForm extends StatelessWidget with SnackMixin {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(
            context,
            state.errorMessage ?? AppLocalizations.of(context)!.translate('auth:text_login_fail'),
            onLinkTap: (String? url, _, __, ___) async {
              if (url?.contains('lost-password') == true) {
                Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
              } else {
                final Uri link = Uri.parse(url ?? '');
                if (await canLaunchUrl(link)) {
                  await launchUrl(link);
                }
              }
            },
          );
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, AppLocalizations.of(context)!.translate('auth:text_login_success'));
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const SizedBox(height: 15),
            _PasswordInput(),
            const SizedBox(height: 5),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: _LoginButtonForgotPassword(),
            ),
            const SizedBox(height: 30),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_user_email'),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            errorText:
                state.username.invalid ? AppLocalizations.of(context)!.translate('validate:text_user_email') : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.account,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_password'),
          focusNode: _passwordFocusNode,
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: _obscureText,
          decoration: InputDecoration(
            errorText:
                state.password.invalid ? AppLocalizations.of(context)!.translate('validate:text_password') : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.lock,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
                if (_passwordFocusNode!.hasFocus == false) {
                  _passwordFocusNode!.unfocus();
                  _passwordFocusNode!.canRequestFocus = false;
                }
              },
              icon: Icon(
                _obscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye_off,
                size: 20,
                color: Theme.of(context).textTheme.overline?.color,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget with LoadingMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        /// you can disable dialog CAPTCHA by set this enable = false
        return CaptchaWrap(
          enable: enableCaptchaLogin,
          submit: (captcha, phrase) {
            context.read<LoginBloc>().add(LoginCaptchaChanged(captcha, phrase));
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
          buildButton: (openCaptcha) {
            return SizedBox(
              width: 120,
              child: ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!state.status.isSubmissionInProgress) {
                    context.read<LoginBloc>().add(LoginOpenCaptcha(openCaptcha: openCaptcha));
                  } else {
                    avoidPrint('Can not click when isSubmissionInProgress');
                  }
                },
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                child: state.status.isSubmissionInProgress
                    ? buildLoadingElevated()
                    : Text(AppLocalizations.of(context)!.translate('auth:text_button_login')),
              ),
            );
          },
        );
      },
    );
  }
}

class _LoginButtonForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.overline,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: Text(AppLocalizations.of(context)!.translate('auth:text_forgot')),
    );
  }
}
