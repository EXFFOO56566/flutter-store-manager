// Themes & UI
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/auth/login_social/login_social.dart';
import 'package:flutter_store_manager/themes.dart';
import 'widgets/widgets.dart';

// Localization
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Form
import 'package:formz/formz.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget with SnackMixin {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? AppLocalizations.of(context)!.translate('auth:text_login_fail'));
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, AppLocalizations.of(context)!.translate('auth:text_login_success'));
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: FirstNameInput(),
              ),
              SizedBox(width: 12),
              Expanded(
                child: LastNameInput(),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const EmailInput(),
          const SizedBox(height: 15),
          const UsernameInput(),
          const SizedBox(height: 15),
          const PasswordInput(),
          const SizedBox(height: 40),
          const RegisterButton(),
          const SizedBox(height: 23),
          Text(AppLocalizations.of(context)!.translate('auth:text_register_social'), style: theme.textTheme.caption),
          const SizedBox(height: 20),
          LoginSocial(
            type: 'register',
            onChangeStatus: (status) => context.read<RegisterBloc>().add(RegisterChangeStatus(status)),
          ),
        ],
      ),
    );
  }
}
