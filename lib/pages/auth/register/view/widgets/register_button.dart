// Themes & UI
import 'package:flutter/material.dart';

// Localization
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

// Form
import 'package:formz/formz.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/register/bloc/register_bloc.dart';

import '../../../../../constants/constants.dart';
import '../../../../captcha/captcha.dart';

class RegisterButton extends StatelessWidget with LoadingMixin {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        /// you can disable dialog CAPTCHA by set this enable = false
        return CaptchaWrap(
          enable: enableCaptchaRegister,
          submit: (captcha, phrase) {
            context.read<RegisterBloc>().add(RegisterCaptchaChanged(captcha, phrase));
            context.read<RegisterBloc>().add(const RegisterSubmitted());
          },
          buildButton: (openCaptcha) {
            return SizedBox(
              width: 150,
              child: ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!state.status.isSubmissionInProgress) {
                    context.read<RegisterBloc>().add(RegisterOpenCaptcha(openCaptcha: openCaptcha));
                  } else {
                    avoidPrint('Can not click when isSubmissionInProgress');
                  }
                },
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                child: state.status.isSubmissionInProgress
                    ? buildLoadingElevated()
                    : Text(AppLocalizations.of(context)!.translate('auth:text_button_register')),
              ),
            );
          },
        );
      },
    );
  }
}
