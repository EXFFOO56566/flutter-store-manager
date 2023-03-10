import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/forgot_password/forgot_password.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.translate('auth:text_forgot_password_fail')),
              ),
            );
        }
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.translate('auth:text_forgot_password_success')),
              ),
            );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate('auth:text_description_forgot'),
            style: theme.textTheme.caption,
          ),
          const SizedBox(height: 20),
          _EmailInput(),
          const SizedBox(height: 40),
          _ForgotPasswordButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_user_email'),
          onChanged: (email) => context.read<ForgotPasswordBloc>().add(ForgotPasswordUsernameChanged(email)),
          decoration: InputDecoration(
            errorText: state.email.invalid ? AppLocalizations.of(context)!.translate('validate:text_email') : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.email,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
            hintText: AppLocalizations.of(context)!.translate('auth:text_forgot_password_hint'),
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget with LoadingMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('forgotPasswordForm_continue_raisedButton'),
            onPressed: () => !state.status.isSubmissionInProgress
                ? context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitted())
                : () => avoidPrint('Can not click when isSubmissionInProgress'),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
            child: state.status.isSubmissionInProgress
                ? buildLoadingElevated()
                : Text(AppLocalizations.of(context)!.translate('common:text_submit')),
          ),
        );
      },
    );
  }
}
