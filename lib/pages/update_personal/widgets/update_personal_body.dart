import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:formz/formz.dart';

import '../bloc/update_personal_bloc.dart';
import '../view/inputs/image.dart';
import '../view/inputs/inputs.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class UpdatePersonalBody extends StatefulWidget {
  const UpdatePersonalBody({Key? key}) : super(key: key);

  @override
  UpdatePersonalBodyState createState() => UpdatePersonalBodyState();
}

class UpdatePersonalBodyState extends State<UpdatePersonalBody> with LoadingMixin, SnackMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  @override
  void initState() {
    context.read<UpdatePersonalBloc>().add(InitData(
          _firstNameController,
          _lastNameController,
          _emailController,
          _phoneController,
          _aboutController,
        ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? translate('account:text_personal_invalid_form'));
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, translate('account:text_personal_save'));
          context.read<AuthenticationBloc>().add(AvatarChanged(state.imageSrc));
        }
      },
      buildWhen: (previous, current) => (previous.actionState != current.actionState),
      builder: (context, state) {
        if (state.actionState == const LoadingState()) {
          return Center(
            child: buildLoading(),
          );
        } else if (state.actionState == const ErrorState()) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).errorColor,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(translate('account:text_personal_error')),
                )
              ],
            ),
          );
        }
        return SingleChildScrollView(
          key: const Key("update_personal"),
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: PersonalFirstName(firstNameController: _firstNameController)),
                  const SizedBox(width: 12),
                  Expanded(child: PersonalLastName(lastNameController: _lastNameController)),
                ],
              ),
              const SizedBox(height: 15),
              PersonalEmail(emailController: _emailController),
              const SizedBox(height: 15),
              PersonalPhone(phoneController: _phoneController),
              const SizedBox(height: 15),
              PersonalAbout(aboutController: _aboutController),
              const SizedBox(height: 12),
              const UpdatePersonalImage(),
              const SizedBox(height: 40),
              const PersonalButton(),
            ],
          ),
        );
      },
    );
  }
}
