import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/constants/auth.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:formz/formz.dart';

import '../../bloc/login_mobile_bloc.dart';

class LoginMobileForm extends StatefulWidget {
  final bool loading;
  final Function onSubmit;

  const LoginMobileForm({Key? key, required this.loading, required this.onSubmit}) : super(key: key);

  @override
  LoginMobileFormState createState() => LoginMobileFormState();
}

class LoginMobileFormState extends State<LoginMobileForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 12, 25, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(translate('auth:text_login_mobile_description'), style: textTheme.caption),
            ),
            const SizedBox(height: 24),
            LabelInput(title: translate('inputs:text_phone_number')),
            _PhoneInput(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: _LoginMobileButton(onSubmit: widget.onSubmit, loading: widget.loading),
            ),
            // sizeBoxLarge,
          ],
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginMobileBloc, LoginMobileState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return InputPhoneNumber(
          initCountryCode: loginNumberMethodDefaultCountryCode,
          hintText: AppLocalizations.of(context)!.translate('auth:text_login_mobile_hint_phone'),
          onChanged: (PhoneNumber phone) => context.read<LoginMobileBloc>().add(LoginPhoneChanged(phone)),
        );
      },
    );
  }
}

class _LoginMobileButton extends StatelessWidget with SnackMixin, LoadingMixin {
  final bool loading;
  final Function onSubmit;

  const _LoginMobileButton({Key? key, required this.onSubmit, required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginMobileBloc, LoginMobileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.status.isValidated
              ? () {
                  if (!state.status.isSubmissionInProgress) {
                    FocusScope.of(context).unfocus();
                    onSubmit();
                  }
                }
              : () => showError(context, AppLocalizations.of(context)!.translate('validate:text_phone')),
          child: state.status.isSubmissionInProgress || loading
              ? buildLoadingElevated()
              : Text(AppLocalizations.of(context)!.translate('common:text_submit')),
        );
      },
    );
  }
}
