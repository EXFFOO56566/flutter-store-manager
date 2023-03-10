import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:formz/formz.dart';

import '../bloc/update_password_bloc.dart';
import '../view/inputs/inputs.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class UpdatePasswordBody extends StatefulWidget {
  const UpdatePasswordBody({Key? key}) : super(key: key);

  @override
  UpdatePasswordBodyState createState() => UpdatePasswordBodyState();
}

class UpdatePasswordBodyState extends State<UpdatePasswordBody> with LoadingMixin, SnackMixin {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(
            context,
            state.errorMessage,
            onLinkTap: (String? url, _, __, ___) async {
              final Uri link = Uri.parse(url ?? '');
              if (await canLaunchUrl(link)) {
                await launchUrl(link);
              }
            },
          );
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, translate('message:text_change_password_success'));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          key: const Key("change password"),
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OldPasswordField(controller: _oldPasswordController),
              const SizedBox(height: 15),
              NewPasswordField(controller: _newPasswordController),
              const SizedBox(height: 15),
              ConfirmPasswordField(controller: _confirmController),
              const SizedBox(height: 40),
              const ButtonChangePassword(),
            ],
          ),
        );
      },
    );
  }
}
